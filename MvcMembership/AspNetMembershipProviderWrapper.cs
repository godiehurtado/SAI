﻿using System.Collections.Generic;
using System.Web.Security;
using PagedList;

namespace MvcMembership
{
	public class AspNetMembershipProviderWrapper : IUserService, IPasswordService
	{
		private readonly MembershipProvider _membershipProvider;

		public AspNetMembershipProviderWrapper(MembershipProvider membershipProvider)
		{
			_membershipProvider = membershipProvider;
		}

		#region IPasswordService Members

		public void Unlock(MembershipUser user)
		{
			user.UnlockUser();
		}

		public string ResetPassword(MembershipUser user, string passwordAnswer)
		{
			return user.ResetPassword(passwordAnswer);
		}

		#endregion

		#region IUserService Members

		public IPagedList<MembershipUser> FindAll(int pageIndex, int pageSize)
		{
			// get one page of users
			int totalUserCount;
            int pageNumber = pageIndex + 1;
			var usersCollection = _membershipProvider.GetAllUsers(pageIndex, pageSize, out totalUserCount);

			// convert from MembershipUserColletion to PagedList<MembershipUser> and return
			var converter = new EnumerableToEnumerableTConverter<MembershipUserCollection, MembershipUser>();
			var usersList = converter.ConvertTo<IEnumerable<MembershipUser>>(usersCollection);
            var usersPagedList = new StaticPagedList<MembershipUser>(usersList, pageNumber, pageSize, totalUserCount);
			return usersPagedList;
		}

        /// <summary>
        /// 
        /// </summary>
        /// <param name="filter"></param>
        /// <param name="pageIndex"></param>
        /// <param name="pageSize"></param>
        /// <returns></returns>
        public IPagedList<MembershipUser> GetUsersByAllFilter(string filter, int pageIndex, int pageSize)
        {
            // get one page of users
            int totalUserCount;
            int pageNumber = pageIndex + 1;
            //var usersCollection = ((SAISqlMembershipProvider)_membershipProvider).FindUsersByAllFilter(filter, pageIndex, pageSize, out totalUserCount);
            var usersCollection = filter.Trim() == string.Empty ? _membershipProvider.GetAllUsers(pageIndex, pageSize, out totalUserCount)
                : _membershipProvider.FindUsersByName(filter, pageIndex, pageSize, out totalUserCount);

            // convert from MembershipUserColletion to PagedList<MembershipUser> and return
            var converter = new EnumerableToEnumerableTConverter<MembershipUserCollection, MembershipUser>();
            var usersList = converter.ConvertTo<IEnumerable<MembershipUser>>(usersCollection);
            var usersPagedList = new StaticPagedList<MembershipUser>(usersList, pageNumber, pageSize, totalUserCount);
            return usersPagedList;
        }

		public IPagedList<MembershipUser> FindByEmail(string emailAddressToMatch, int pageIndex, int pageSize)
		{
			// get one page of users
			int totalUserCount;
            int pageNumber = pageIndex + 1;
			var usersCollection = _membershipProvider.FindUsersByEmail(emailAddressToMatch, pageIndex, pageSize, out totalUserCount);

			// convert from MembershipUserColletion to PagedList<MembershipUser> and return
			var converter = new EnumerableToEnumerableTConverter<MembershipUserCollection, MembershipUser>();
			var usersList = converter.ConvertTo<IEnumerable<MembershipUser>>(usersCollection);
            var usersPagedList = new StaticPagedList<MembershipUser>(usersList, pageNumber, pageSize, totalUserCount);
			return usersPagedList;
		}

		public IPagedList<MembershipUser> FindByUserName(string userNameToMatch, int pageIndex, int pageSize)
		{
			// get one page of users
			int totalUserCount;
            int pageNumber = pageIndex + 1;
            var usersCollection = _membershipProvider.FindUsersByName(userNameToMatch, pageIndex, pageSize, out totalUserCount);

			// convert from MembershipUserColletion to PagedList<MembershipUser> and return
			var converter = new EnumerableToEnumerableTConverter<MembershipUserCollection, MembershipUser>();
			var usersList = converter.ConvertTo<IEnumerable<MembershipUser>>(usersCollection);
            var usersPagedList = new StaticPagedList<MembershipUser>(usersList, pageNumber, pageSize, totalUserCount);
			return usersPagedList;
		}

		public MembershipUser Get(string userName)
		{
			return _membershipProvider.GetUser(userName, false);
		}

		public MembershipUser Get(object providerUserKey)
		{
			return _membershipProvider.GetUser(providerUserKey, false);
		}

		public void Update(MembershipUser user)
		{
			_membershipProvider.UpdateUser(user);
		}

		public void Delete(MembershipUser user)
		{
			_membershipProvider.DeleteUser(user.UserName, false);
		}

		public MembershipUser Touch(MembershipUser user)
		{
			return _membershipProvider.GetUser(user.UserName, true);
		}

		public MembershipUser Touch(string userName)
		{
			return _membershipProvider.GetUser(userName, true);
		}

		public MembershipUser Touch(object providerUserKey)
		{
			return _membershipProvider.GetUser(providerUserKey, true);
		}

		public int TotalUsers
		{
			get
			{
				int totalUsers;
				_membershipProvider.GetAllUsers(1, 1, out totalUsers);
				return totalUsers;
			}
		}

		public int UsersOnline
		{
			get
			{
				return _membershipProvider.GetNumberOfUsersOnline();
			}
		}

		#endregion


       
    }
}