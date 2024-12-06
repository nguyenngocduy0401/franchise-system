﻿using FluentValidation;
using FranchiseProject.Application.ViewModels.UserViewModels;

namespace FranchiseProject.API.Validator.UserValidator
{
    public class UpdateUserByLoginValidator : AbstractValidator<UpdateUserByLoginModel>
    {
        public UpdateUserByLoginValidator()
        {
            RuleFor(x => x.FullName)
                .NotEmpty()
                .WithMessage("Họ và tên không được để trống.");

            RuleFor(x => x.Email)
                .NotEmpty()
                .EmailAddress()
                .WithMessage("Địa chỉ email không hợp lệ!");

            RuleFor(x => x.PhoneNumber)
                .NotEmpty()
                .Matches(@"^0[0-9]{9}$")
                .WithMessage("Số điện thoại phải có 10 chữ số và bắt đầu bằng số 0!");
        }
    }
}