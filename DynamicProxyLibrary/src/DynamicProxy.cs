#region Copyright Notice
// ----------------------------------------------------------------------------
// Copyright (C) 2006 Microsoft Corporation, All rights reserved.
// ----------------------------------------------------------------------------

// Author: Vipul Modi (vipul.modi@microsoft.com)
#endregion

namespace  DynamicProxyLibrary.DynamicProxy
{
    using System;
    using System.Reflection;
    using System.ServiceModel;
    using System.ServiceModel.Channels;

    public class DynamicProxy : DynamicObject
    {
        public DynamicProxy(Type proxyType, Binding binding, 
                EndpointAddress address)
            : base(proxyType)
        {
            Type[] paramTypes = new Type[2];
            paramTypes[0] = typeof(Binding);
            paramTypes[1] = typeof(EndpointAddress);

            object[] paramValues = new object[2];
            paramValues[0] = binding;
            paramValues[1] = address;

            CallConstructor(paramTypes, paramValues);
        }

        public Type ProxyType
        {
            get
            {
                return ObjectType;
            }
        }

        public object Proxy
        {
            get
            {
                return ObjectInstance;
            }
        }

        public void Close()
        {
            CallMethod("Close");
        }
    }
}
