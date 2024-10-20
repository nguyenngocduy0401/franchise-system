using AutoMapper;
using FranchiseProject.Application.Commons;
using FranchiseProject.Application.ViewModels.ConsultationViewModels;
using FranchiseProject.Application.ViewModels.ClassScheduleViewModels;
using FranchiseProject.Application.ViewModels.ContractViewModels;
using FranchiseProject.Application.ViewModels.CourseCategoryViewModels;
using FranchiseProject.Application.ViewModels.NotificationViewModels;
using FranchiseProject.Application.ViewModels.SlotViewModels;
using FranchiseProject.Application.ViewModels.UserViewModels;
using FranchiseProject.Domain.Entity;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FranchiseProject.Application.ViewModels.MaterialViewModels;
using FranchiseProject.Application.ViewModels.ChapterViewModels;
using FranchiseProject.Application.ViewModels.SessionViewModels;
using FranchiseProject.Application.ViewModels.AssessmentViewModels;
using FranchiseProject.Application.ViewModels.CourseViewModels;
using FranchiseProject.Application.ViewModels.SyllabusViewModels;

namespace FranchiseProject.Infrastructures.Mappers
{
    public class MapperConfigurationsProfile : Profile 
    {
        public MapperConfigurationsProfile() {
            #region FranchiseRegist
            CreateMap<ConsultationViewModel, Consultation>();
            CreateMap<RegisterConsultationViewModel, Consultation>();
            CreateMap<Consultation, ConsultationViewModel>().ReverseMap();
            CreateMap<Consultation, ConsultationViewModel>()
            .ForMember(dest => dest.ConsultantUserName, opt => opt.MapFrom(src => src.User != null ? src.User.UserName : string.Empty));
            #endregion
            #region Agency
            CreateMap<CreateAgencyViewModel, Agency>().ReverseMap();
            CreateMap<Agency, AgencyViewModel>();
            #endregion
            #region Contract
            CreateMap<CreateContractViewModel, Contract>().ReverseMap();
            CreateMap<Contract, ContractViewModel>().ForMember(dest => dest.AgencyName,otp => otp.MapFrom(src=>src.Agency.Name));

            #endregion
            #region User
            CreateMap<User, UserViewModel>()
            .ForMember(dest => dest.Role, opt => opt.MapFrom(src =>
            src.UserRoles == null ? null: src.UserRoles.Select(ur => ur.Role.Name).FirstOrDefault()));
            CreateMap<CreateUserByAdminModel, User>()
            .ForMember(dest => dest.AgencyId, opt => opt
            .MapFrom(src => string.IsNullOrEmpty(src.AgencyId) ? (Guid?)null : Guid.Parse(src.AgencyId)))
            .ForMember(dest => dest.PasswordHash, src => src.MapFrom(x => x.Password));
            CreateMap<CreateUserByAdminModel, User>()
            .ForMember(dest => dest.AgencyId, opt => opt
            .MapFrom(src => string.IsNullOrEmpty(src.AgencyId) ? (Guid?)null : Guid.Parse(src.AgencyId)))
            .ForMember(dest => dest.PasswordHash, src => src.MapFrom(x => x.Password));
            CreateMap<CreateUserByAdminModel, User>()
            .ForMember(dest => dest.AgencyId, opt => opt
            .MapFrom(src => string.IsNullOrEmpty(src.AgencyId) ? (Guid?)null : Guid.Parse(src.AgencyId)))
            .ForMember(dest => dest.PasswordHash, src => src.MapFrom(x => x.Password));
            CreateMap<CreateUserByAdminModel, User>()
            .ForMember(dest => dest.AgencyId, opt => opt.MapFrom(src =>
                string.IsNullOrEmpty(src.AgencyId) ? (Guid?)null : Guid.Parse(src.AgencyId)))
            .ForMember(dest => dest.PasswordHash, src => src.MapFrom(x => x.Password));
            CreateMap<UpdateUserByAgencyModel, User>();
            CreateMap<CreateUserByAgencyModel, User>();
            CreateMap<User, CreateUserViewModel>();
            #endregion
            #region Slot
            CreateMap<CreateSlotModel, Slot>();
            CreateMap<Slot, SlotViewModel>();
            CreateMap<Pagination<Slot>, Pagination<SlotViewModel>>().ReverseMap();
            #endregion
            #region CourseCategory
            CreateMap<Pagination<CourseCategory>, Pagination<CourseCategoryViewModel>>();
            CreateMap<CreateCourseCategoryModel, CourseCategory>();
            CreateMap<UpdateCourseCategoryModel, CourseCategory>();
            CreateMap<CourseCategory, CourseCategoryViewModel>();
            #endregion
            #region ClassSchedule
            CreateMap<ClassSchedule, ClassScheduleViewModel>()
              .ForMember(dest => dest.ClassName, opt => opt.MapFrom(src => src.Class.Name))
            .ForMember(dest => dest.SlotName, opt => opt.MapFrom(src => src.Slot.Name)).ReverseMap();
            CreateMap<ClassSchedule, ClassScheduleViewModel>()
          .ReverseMap();

            CreateMap<Pagination<ClassSchedule>, Pagination<ClassScheduleViewModel>>()
                .ForMember(dest => dest.Items, opt => opt.MapFrom(src => src.Items));
            #endregion
            #region Notification
            CreateMap<Notification, NotificationViewModel>()
            .ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.Id))
            .ForMember(dest => dest.Message, opt => opt.MapFrom(src => src.Message)).ReverseMap();
            #endregion
            #region Material
            CreateMap<Material, MaterialViewModel>();
            CreateMap<CreateMaterialModel, Material>();
            CreateMap<UpdateMaterialModel, Material>();
            #endregion
            #region Chapter
            CreateMap<Chapter, ChapterViewModel>();
            CreateMap<CreateChapterModel, Chapter>();
            CreateMap<UpdateChapterModel, Chapter>();
            #endregion
            #region Session
            CreateMap<Session, SessionViewModel>();
            CreateMap<CreateSessionModel, Session>();
            CreateMap<UpdateSessionModel, Session>();
            #endregion
            #region Assessment
            CreateMap<Assessment, AssessmentViewModel>();
            CreateMap<CreateAssessmentModel, Assessment>();
            CreateMap<UpdateAssessmentModel, Assessment>();
            #endregion
            #region Course
            CreateMap<Course, CourseViewModel>()
                .ForMember(dest => dest.CourseCategoryName, opt => opt
                .MapFrom(src => src.CourseCategory.Name));
            CreateMap<Course, CourseDetailViewModel>()
                .ForMember(dest => dest.Materials, opt => opt.MapFrom(src => src.Materials.Where(m => m.IsDeleted != true)))
                .ForMember(dest => dest.Sessions, opt => opt.MapFrom(src => src.Sessions.Where(m => m.IsDeleted != true)))
                .ForMember(dest => dest.Assessments, opt => opt.MapFrom(src => src.Assessments.Where(m => m.IsDeleted != true)))
                .ForMember(dest => dest.Chapters, opt => opt.MapFrom(src => src.Chapters.Where(m => m.IsDeleted != true)))
                .ForMember(dest => dest.Syllabus, opt => opt.MapFrom(src => src.Syllabus))
                .ForMember(dest => dest.CourseCategory, opt => opt.MapFrom(src => src.CourseCategory));
            CreateMap<Pagination<Course>, Pagination<CourseViewModel>>()
                .ForMember(dest => dest.Items, opt => opt.MapFrom(src => src.Items));
            CreateMap<CreateCourseModel, Course>()
                .ForMember(dest => dest.Status, opt => opt.MapFrom(src => Domain.Enums.CourseStatusEnum.Draft));
            CreateMap<UpdateCourseModel, Course>();
            CreateMap<CreateMaterialArrangeModel, Material>();
            CreateMap<CreateChapterArrangeModel, Chapter>();
            CreateMap<CreateAssessmentArrangeModel, Assessment>();
            CreateMap<CreateSessionArrangeModel, Session>();
            #endregion
            #region Syllabus
            CreateMap<CreateSyllabusModel, Syllabus>();
            CreateMap<UpdateSyllabusModel, Syllabus>();
            CreateMap<Syllabus, SyllabusViewModel>()
                .ForMember(dest => dest.CourseId, opt => opt.MapFrom(src => src.Courses.FirstOrDefault().Id));
            #endregion
        }
    }
}
