﻿using FranchiseProject.Application.Commons;
using FranchiseProject.Application.Handler;
using FranchiseProject.Application.Interfaces;
using FranchiseProject.Application.ViewModels.DashBoard;
using FranchiseProject.Domain.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FranchiseProject.Application.Services
{
    public class DashboardService :IDashboardService
    {
        private readonly IUnitOfWork _unitOfWork;

        public DashboardService(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }
        public async Task<ApiResponse<RevenueStatisticsViewModel>> GetRevenueStatistics()
        {
            try
            {
                var contracts = await _unitOfWork.ContractRepository.GetAllAsync();
                if (contracts == null)
                {
                    return ResponseHandler.Success< RevenueStatisticsViewModel>(null,"không có dữ liệu truy xuất !");
                }
                var payments = await _unitOfWork.PaymentRepository.GetAllAsync();

                double? totalRevenue = 0;
                double? collectedRevenue = 0;
                double? unpaidRevenue = 0;

                foreach (var contract in contracts)
                {
                    totalRevenue += contract.Total;
                    collectedRevenue += contract.PaidAmount;
                }

                unpaidRevenue = totalRevenue - collectedRevenue;

                var revenueStatistics = new RevenueStatisticsViewModel
                {
                    TotalRevenue = (double) totalRevenue,
                    CollectedRevenue = (double) collectedRevenue,
                    UnpaidRevenue = (double) unpaidRevenue
                };

                return ResponseHandler.Success(revenueStatistics, "Revenue statistics retrieved successfully.");
            }
            catch (Exception ex)
            {
                return ResponseHandler.Failure<RevenueStatisticsViewModel>($"Error retrieving revenue statistics: {ex.Message}");
            }
        }
        public async Task<ApiResponse<Pagination<AgencyStatisticsViewModel>>> GetAgencyStatistics(DateTime startDate, DateTime endDate, int pageNumber, int pageSize)
        {
            try
            {
                var agencies = await _unitOfWork.AgencyRepository.GetAllAsync();
                var agencyStatistics = new List<AgencyStatisticsViewModel>();

                foreach (var agency in agencies)
                {
                    var latestContract = await _unitOfWork.ContractRepository.GetMostRecentContractByAgencyIdAsync(agency.Id);

                    if (latestContract == null)
                    {
                        continue; 
                    }

                    var registerCourses = await _unitOfWork.RegisterCourseRepository.GetRegisterCoursesByAgencyIdAndDateRange(agency.Id, startDate, endDate);
                    var payments = await _unitOfWork.PaymentRepository.GetPaymentsByAgencyIdAndDateRange(agency.Id, startDate, endDate);

                    int totalStudents = registerCourses.Count;
                    double totalRevenue = payments.Where(p => p.Type == PaymentTypeEnum.Course).Sum(p => p.Amount ?? 0);
                    double revenueToHeadquarters = (double)(totalRevenue * (latestContract.RevenueSharePercentage / 100));

                    var monthlyPayments = payments.Where(p => p.Type == PaymentTypeEnum.MonthlyDue).ToList();
                    bool allMonthlyPaymentsPaid = monthlyPayments.All(p => p.Status == PaymentStatus.Completed);

                    agencyStatistics.Add(new AgencyStatisticsViewModel
                    {
                        AgencyId = agency.Id,
                        AgencyName = agency.Name,
                        TotalStudents = totalStudents,
                        TotalRevenue = totalRevenue,
                        RevenueToHeadquarters = revenueToHeadquarters,
                        MonthlyPaymentStatus = allMonthlyPaymentsPaid ? "Paid" : "Pending"
                    });
                }
                var paginatedResult = new Pagination<AgencyStatisticsViewModel>
                {
                    TotalItemsCount = agencyStatistics.Count,
                    PageSize = pageSize,
                    PageIndex = pageNumber,
                    Items = agencyStatistics.Skip((pageNumber - 1) * pageSize).Take(pageSize).ToList()
                };

                return ResponseHandler.Success(paginatedResult, "Agency statistics retrieved successfully.");
            }
            catch (Exception ex)
            {
                return ResponseHandler.Failure<Pagination<AgencyStatisticsViewModel>>($"Error retrieving agency statistics: {ex.Message}");
            }
        }
    }
}