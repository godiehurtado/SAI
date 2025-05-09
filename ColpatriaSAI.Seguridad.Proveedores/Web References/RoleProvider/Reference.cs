﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.235
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

// 
// This source code was auto-generated by Microsoft.VSDesigner, Version 4.0.30319.235.
// 
using System.Configuration;
using System.Web.Configuration;

#pragma warning disable 1591

namespace ColpatriaSAI.Seguridad.Proveedores.RoleProvider {
    using System;
    using System.Web.Services;
    using System.Diagnostics;
    using System.Web.Services.Protocols;
    using System.ComponentModel;
    using System.Xml.Serialization;
    
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Web.Services.WebServiceBindingAttribute(Name="RoleProviderSoap", Namespace="http://tempuri.org/")]
    public partial class RoleProvider : System.Web.Services.Protocols.SoapHttpClientProtocol {
        
        private System.Threading.SendOrPostCallback AddUsersToRolesOperationCompleted;
        
        private System.Threading.SendOrPostCallback CreateRoleOperationCompleted;
        
        private System.Threading.SendOrPostCallback DeleteRoleOperationCompleted;
        
        private System.Threading.SendOrPostCallback FindUsersInRoleOperationCompleted;
        
        private System.Threading.SendOrPostCallback GetAllRolesOperationCompleted;
        
        private System.Threading.SendOrPostCallback GetRolesForUserOperationCompleted;
        
        private System.Threading.SendOrPostCallback GetUsersInRoleOperationCompleted;
        
        private System.Threading.SendOrPostCallback IsUserInRoleOperationCompleted;
        
        private System.Threading.SendOrPostCallback RemoveUsersFromRolesOperationCompleted;
        
        private System.Threading.SendOrPostCallback RoleExistsOperationCompleted;
        
        private bool useDefaultCredentialsSetExplicitly;
        
        /// <remarks/>
        public RoleProvider() {
             var configurationManager = WebConfigurationManager.OpenWebConfiguration("/");
             var section = (System.Web.Configuration.RoleManagerSection)configurationManager.GetSection("system.web/roleManager");
                this.Url = section.Providers[0].Parameters["roleProviderUri"]; //global::ColpatriaSAI.Seguridad.Proveedores.Properties.Settings.Default.ColpatriaSAI_Seguridad_Proveedores_RoleProvider_RoleProvider;
            if ((this.IsLocalFileSystemWebService(this.Url) == true)) {
                this.UseDefaultCredentials = true;
                this.useDefaultCredentialsSetExplicitly = false;
            }
            else {
                this.useDefaultCredentialsSetExplicitly = true;
            }
        }
        
        public new string Url {
            get {
                return base.Url;
            }
            set {
                if ((((this.IsLocalFileSystemWebService(base.Url) == true) 
                            && (this.useDefaultCredentialsSetExplicitly == false)) 
                            && (this.IsLocalFileSystemWebService(value) == false))) {
                    base.UseDefaultCredentials = false;
                }
                base.Url = value;
            }
        }
        
        public new bool UseDefaultCredentials {
            get {
                return base.UseDefaultCredentials;
            }
            set {
                base.UseDefaultCredentials = value;
                this.useDefaultCredentialsSetExplicitly = true;
            }
        }
        
        /// <remarks/>
        public event AddUsersToRolesCompletedEventHandler AddUsersToRolesCompleted;
        
        /// <remarks/>
        public event CreateRoleCompletedEventHandler CreateRoleCompleted;
        
        /// <remarks/>
        public event DeleteRoleCompletedEventHandler DeleteRoleCompleted;
        
        /// <remarks/>
        public event FindUsersInRoleCompletedEventHandler FindUsersInRoleCompleted;
        
        /// <remarks/>
        public event GetAllRolesCompletedEventHandler GetAllRolesCompleted;
        
        /// <remarks/>
        public event GetRolesForUserCompletedEventHandler GetRolesForUserCompleted;
        
        /// <remarks/>
        public event GetUsersInRoleCompletedEventHandler GetUsersInRoleCompleted;
        
        /// <remarks/>
        public event IsUserInRoleCompletedEventHandler IsUserInRoleCompleted;
        
        /// <remarks/>
        public event RemoveUsersFromRolesCompletedEventHandler RemoveUsersFromRolesCompleted;
        
        /// <remarks/>
        public event RoleExistsCompletedEventHandler RoleExistsCompleted;
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/AddUsersToRoles", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public void AddUsersToRoles(string providerName, string applicationName, string[] usernames, string[] roleNames) {
            this.Invoke("AddUsersToRoles", new object[] {
                        providerName,
                        applicationName,
                        usernames,
                        roleNames});
        }
        
        /// <remarks/>
        public void AddUsersToRolesAsync(string providerName, string applicationName, string[] usernames, string[] roleNames) {
            this.AddUsersToRolesAsync(providerName, applicationName, usernames, roleNames, null);
        }
        
        /// <remarks/>
        public void AddUsersToRolesAsync(string providerName, string applicationName, string[] usernames, string[] roleNames, object userState) {
            if ((this.AddUsersToRolesOperationCompleted == null)) {
                this.AddUsersToRolesOperationCompleted = new System.Threading.SendOrPostCallback(this.OnAddUsersToRolesOperationCompleted);
            }
            this.InvokeAsync("AddUsersToRoles", new object[] {
                        providerName,
                        applicationName,
                        usernames,
                        roleNames}, this.AddUsersToRolesOperationCompleted, userState);
        }
        
        private void OnAddUsersToRolesOperationCompleted(object arg) {
            if ((this.AddUsersToRolesCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.AddUsersToRolesCompleted(this, new System.ComponentModel.AsyncCompletedEventArgs(invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/CreateRole", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public void CreateRole(string providerName, string applicationName, string roleName) {
            this.Invoke("CreateRole", new object[] {
                        providerName,
                        applicationName,
                        roleName});
        }
        
        /// <remarks/>
        public void CreateRoleAsync(string providerName, string applicationName, string roleName) {
            this.CreateRoleAsync(providerName, applicationName, roleName, null);
        }
        
        /// <remarks/>
        public void CreateRoleAsync(string providerName, string applicationName, string roleName, object userState) {
            if ((this.CreateRoleOperationCompleted == null)) {
                this.CreateRoleOperationCompleted = new System.Threading.SendOrPostCallback(this.OnCreateRoleOperationCompleted);
            }
            this.InvokeAsync("CreateRole", new object[] {
                        providerName,
                        applicationName,
                        roleName}, this.CreateRoleOperationCompleted, userState);
        }
        
        private void OnCreateRoleOperationCompleted(object arg) {
            if ((this.CreateRoleCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.CreateRoleCompleted(this, new System.ComponentModel.AsyncCompletedEventArgs(invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/DeleteRole", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public bool DeleteRole(string providerName, string applicationName, string roleName, bool throwOnPopulatedRole) {
            object[] results = this.Invoke("DeleteRole", new object[] {
                        providerName,
                        applicationName,
                        roleName,
                        throwOnPopulatedRole});
            return ((bool)(results[0]));
        }
        
        /// <remarks/>
        public void DeleteRoleAsync(string providerName, string applicationName, string roleName, bool throwOnPopulatedRole) {
            this.DeleteRoleAsync(providerName, applicationName, roleName, throwOnPopulatedRole, null);
        }
        
        /// <remarks/>
        public void DeleteRoleAsync(string providerName, string applicationName, string roleName, bool throwOnPopulatedRole, object userState) {
            if ((this.DeleteRoleOperationCompleted == null)) {
                this.DeleteRoleOperationCompleted = new System.Threading.SendOrPostCallback(this.OnDeleteRoleOperationCompleted);
            }
            this.InvokeAsync("DeleteRole", new object[] {
                        providerName,
                        applicationName,
                        roleName,
                        throwOnPopulatedRole}, this.DeleteRoleOperationCompleted, userState);
        }
        
        private void OnDeleteRoleOperationCompleted(object arg) {
            if ((this.DeleteRoleCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.DeleteRoleCompleted(this, new DeleteRoleCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/FindUsersInRole", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public string[] FindUsersInRole(string providerName, string applicationName, string roleName, string usernameToMatch) {
            object[] results = this.Invoke("FindUsersInRole", new object[] {
                        providerName,
                        applicationName,
                        roleName,
                        usernameToMatch});
            return ((string[])(results[0]));
        }
        
        /// <remarks/>
        public void FindUsersInRoleAsync(string providerName, string applicationName, string roleName, string usernameToMatch) {
            this.FindUsersInRoleAsync(providerName, applicationName, roleName, usernameToMatch, null);
        }
        
        /// <remarks/>
        public void FindUsersInRoleAsync(string providerName, string applicationName, string roleName, string usernameToMatch, object userState) {
            if ((this.FindUsersInRoleOperationCompleted == null)) {
                this.FindUsersInRoleOperationCompleted = new System.Threading.SendOrPostCallback(this.OnFindUsersInRoleOperationCompleted);
            }
            this.InvokeAsync("FindUsersInRole", new object[] {
                        providerName,
                        applicationName,
                        roleName,
                        usernameToMatch}, this.FindUsersInRoleOperationCompleted, userState);
        }
        
        private void OnFindUsersInRoleOperationCompleted(object arg) {
            if ((this.FindUsersInRoleCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.FindUsersInRoleCompleted(this, new FindUsersInRoleCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/GetAllRoles", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public string[] GetAllRoles(string providerName, string applicationName) {
            object[] results = this.Invoke("GetAllRoles", new object[] {
                        providerName,
                        applicationName});
            return ((string[])(results[0]));
        }
        
        /// <remarks/>
        public void GetAllRolesAsync(string providerName, string applicationName) {
            this.GetAllRolesAsync(providerName, applicationName, null);
        }
        
        /// <remarks/>
        public void GetAllRolesAsync(string providerName, string applicationName, object userState) {
            if ((this.GetAllRolesOperationCompleted == null)) {
                this.GetAllRolesOperationCompleted = new System.Threading.SendOrPostCallback(this.OnGetAllRolesOperationCompleted);
            }
            this.InvokeAsync("GetAllRoles", new object[] {
                        providerName,
                        applicationName}, this.GetAllRolesOperationCompleted, userState);
        }
        
        private void OnGetAllRolesOperationCompleted(object arg) {
            if ((this.GetAllRolesCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.GetAllRolesCompleted(this, new GetAllRolesCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/GetRolesForUser", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public string[] GetRolesForUser(string providerName, string applicationName, string username) {
            object[] results = this.Invoke("GetRolesForUser", new object[] {
                        providerName,
                        applicationName,
                        username});
            return ((string[])(results[0]));
        }
        
        /// <remarks/>
        public void GetRolesForUserAsync(string providerName, string applicationName, string username) {
            this.GetRolesForUserAsync(providerName, applicationName, username, null);
        }
        
        /// <remarks/>
        public void GetRolesForUserAsync(string providerName, string applicationName, string username, object userState) {
            if ((this.GetRolesForUserOperationCompleted == null)) {
                this.GetRolesForUserOperationCompleted = new System.Threading.SendOrPostCallback(this.OnGetRolesForUserOperationCompleted);
            }
            this.InvokeAsync("GetRolesForUser", new object[] {
                        providerName,
                        applicationName,
                        username}, this.GetRolesForUserOperationCompleted, userState);
        }
        
        private void OnGetRolesForUserOperationCompleted(object arg) {
            if ((this.GetRolesForUserCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.GetRolesForUserCompleted(this, new GetRolesForUserCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/GetUsersInRole", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public string[] GetUsersInRole(string providerName, string applicationName, string roleName) {
            object[] results = this.Invoke("GetUsersInRole", new object[] {
                        providerName,
                        applicationName,
                        roleName});
            return ((string[])(results[0]));
        }
        
        /// <remarks/>
        public void GetUsersInRoleAsync(string providerName, string applicationName, string roleName) {
            this.GetUsersInRoleAsync(providerName, applicationName, roleName, null);
        }
        
        /// <remarks/>
        public void GetUsersInRoleAsync(string providerName, string applicationName, string roleName, object userState) {
            if ((this.GetUsersInRoleOperationCompleted == null)) {
                this.GetUsersInRoleOperationCompleted = new System.Threading.SendOrPostCallback(this.OnGetUsersInRoleOperationCompleted);
            }
            this.InvokeAsync("GetUsersInRole", new object[] {
                        providerName,
                        applicationName,
                        roleName}, this.GetUsersInRoleOperationCompleted, userState);
        }
        
        private void OnGetUsersInRoleOperationCompleted(object arg) {
            if ((this.GetUsersInRoleCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.GetUsersInRoleCompleted(this, new GetUsersInRoleCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/IsUserInRole", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public bool IsUserInRole(string providerName, string applicationName, string username, string roleName) {
            object[] results = this.Invoke("IsUserInRole", new object[] {
                        providerName,
                        applicationName,
                        username,
                        roleName});
            return ((bool)(results[0]));
        }
        
        /// <remarks/>
        public void IsUserInRoleAsync(string providerName, string applicationName, string username, string roleName) {
            this.IsUserInRoleAsync(providerName, applicationName, username, roleName, null);
        }
        
        /// <remarks/>
        public void IsUserInRoleAsync(string providerName, string applicationName, string username, string roleName, object userState) {
            if ((this.IsUserInRoleOperationCompleted == null)) {
                this.IsUserInRoleOperationCompleted = new System.Threading.SendOrPostCallback(this.OnIsUserInRoleOperationCompleted);
            }
            this.InvokeAsync("IsUserInRole", new object[] {
                        providerName,
                        applicationName,
                        username,
                        roleName}, this.IsUserInRoleOperationCompleted, userState);
        }
        
        private void OnIsUserInRoleOperationCompleted(object arg) {
            if ((this.IsUserInRoleCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.IsUserInRoleCompleted(this, new IsUserInRoleCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/RemoveUsersFromRoles", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public void RemoveUsersFromRoles(string providerName, string applicationName, string[] usernames, string[] roleNames) {
            this.Invoke("RemoveUsersFromRoles", new object[] {
                        providerName,
                        applicationName,
                        usernames,
                        roleNames});
        }
        
        /// <remarks/>
        public void RemoveUsersFromRolesAsync(string providerName, string applicationName, string[] usernames, string[] roleNames) {
            this.RemoveUsersFromRolesAsync(providerName, applicationName, usernames, roleNames, null);
        }
        
        /// <remarks/>
        public void RemoveUsersFromRolesAsync(string providerName, string applicationName, string[] usernames, string[] roleNames, object userState) {
            if ((this.RemoveUsersFromRolesOperationCompleted == null)) {
                this.RemoveUsersFromRolesOperationCompleted = new System.Threading.SendOrPostCallback(this.OnRemoveUsersFromRolesOperationCompleted);
            }
            this.InvokeAsync("RemoveUsersFromRoles", new object[] {
                        providerName,
                        applicationName,
                        usernames,
                        roleNames}, this.RemoveUsersFromRolesOperationCompleted, userState);
        }
        
        private void OnRemoveUsersFromRolesOperationCompleted(object arg) {
            if ((this.RemoveUsersFromRolesCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.RemoveUsersFromRolesCompleted(this, new System.ComponentModel.AsyncCompletedEventArgs(invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/RoleExists", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public bool RoleExists(string providerName, string applicationName, string roleName) {
            object[] results = this.Invoke("RoleExists", new object[] {
                        providerName,
                        applicationName,
                        roleName});
            return ((bool)(results[0]));
        }
        
        /// <remarks/>
        public void RoleExistsAsync(string providerName, string applicationName, string roleName) {
            this.RoleExistsAsync(providerName, applicationName, roleName, null);
        }
        
        /// <remarks/>
        public void RoleExistsAsync(string providerName, string applicationName, string roleName, object userState) {
            if ((this.RoleExistsOperationCompleted == null)) {
                this.RoleExistsOperationCompleted = new System.Threading.SendOrPostCallback(this.OnRoleExistsOperationCompleted);
            }
            this.InvokeAsync("RoleExists", new object[] {
                        providerName,
                        applicationName,
                        roleName}, this.RoleExistsOperationCompleted, userState);
        }
        
        private void OnRoleExistsOperationCompleted(object arg) {
            if ((this.RoleExistsCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.RoleExistsCompleted(this, new RoleExistsCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        public new void CancelAsync(object userState) {
            base.CancelAsync(userState);
        }
        
        private bool IsLocalFileSystemWebService(string url) {
            if (((url == null) 
                        || (url == string.Empty))) {
                return false;
            }
            System.Uri wsUri = new System.Uri(url);
            if (((wsUri.Port >= 1024) 
                        && (string.Compare(wsUri.Host, "localHost", System.StringComparison.OrdinalIgnoreCase) == 0))) {
                return true;
            }
            return false;
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    public delegate void AddUsersToRolesCompletedEventHandler(object sender, System.ComponentModel.AsyncCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    public delegate void CreateRoleCompletedEventHandler(object sender, System.ComponentModel.AsyncCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    public delegate void DeleteRoleCompletedEventHandler(object sender, DeleteRoleCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class DeleteRoleCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal DeleteRoleCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public bool Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((bool)(this.results[0]));
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    public delegate void FindUsersInRoleCompletedEventHandler(object sender, FindUsersInRoleCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class FindUsersInRoleCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal FindUsersInRoleCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public string[] Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((string[])(this.results[0]));
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    public delegate void GetAllRolesCompletedEventHandler(object sender, GetAllRolesCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class GetAllRolesCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal GetAllRolesCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public string[] Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((string[])(this.results[0]));
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    public delegate void GetRolesForUserCompletedEventHandler(object sender, GetRolesForUserCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class GetRolesForUserCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal GetRolesForUserCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public string[] Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((string[])(this.results[0]));
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    public delegate void GetUsersInRoleCompletedEventHandler(object sender, GetUsersInRoleCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class GetUsersInRoleCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal GetUsersInRoleCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public string[] Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((string[])(this.results[0]));
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    public delegate void IsUserInRoleCompletedEventHandler(object sender, IsUserInRoleCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class IsUserInRoleCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal IsUserInRoleCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public bool Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((bool)(this.results[0]));
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    public delegate void RemoveUsersFromRolesCompletedEventHandler(object sender, System.ComponentModel.AsyncCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    public delegate void RoleExistsCompletedEventHandler(object sender, RoleExistsCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class RoleExistsCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal RoleExistsCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public bool Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((bool)(this.results[0]));
            }
        }
    }
}

#pragma warning restore 1591