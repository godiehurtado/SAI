#region Copyright Notice
// ----------------------------------------------------------------------------
// Copyright (C) 2006 Microsoft Corporation, All rights reserved.
// ----------------------------------------------------------------------------

// Author: Vipul Modi (vipul.modi@microsoft.com)
#endregion

namespace  DynamicProxyLibrary.DynamicProxy
{
    using System;
   
    internal class Constants
    {
        internal class ErrorMessages
        {
            internal const string ImportError = 
                "There was an error in importing the metadata.";

            internal const string CodeGenerationError = 
                "There was an error in generating the proxy code.";

            internal const string CompilationError = 
                "There was an error in compiling the proxy code.";

            internal const string UnknownContract =
                "The specified contract is not found in the proxy assembly.";

            internal const string EndpointNotFound = 
                "The endpoint associated with contract {1}:{0} is not found.";

            internal const string ProxyTypeNotFound = 
                "The proxy that implements the service contract {0} is not found.";

            internal const string ProxyCtorNotFound = 
                "The constructor matching the specified parameter types is not found.";

            internal const string ParameterValueMistmatch =
                "The type for each parameter values must be specified.";

            internal const string MethodNotFound =
                "The method {0} is not found.";
        }
    } 
}
