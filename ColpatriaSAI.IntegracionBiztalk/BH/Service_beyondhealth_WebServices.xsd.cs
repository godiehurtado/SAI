namespace BizTalkSai_Project.BH {
    using Microsoft.XLANGs.BaseTypes;
    
    
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("Microsoft.BizTalk.Schema.Compiler", "3.0.1.0")]
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [SchemaType(SchemaTypeEnum.Document)]
    [System.SerializableAttribute()]
    [SchemaRoots(new string[] {@"WSContractsByMemberMPP", @"WSContractsByMemberMPPResponse", @"WSMembersByContractCodeMPP", @"WSMembersByContractCodeMPPResponse", @"WSMembersByContractApplicationCodeMPP", @"WSMembersByContractApplicationCodeMPPResponse", @"WSMemberInformationByContractCodeMPP", @"WSMemberInformationByContractCodeMPPResponse", @"WSMemberInformationByContractApplicationCodeMPP", @"WSMemberInformationByContractApplicationCodeMPPResponse", @"WSCollectiveContractsByIntermediaryMPP", @"WSCollectiveContractsByIntermediaryMPPResponse", 
@"WSSearchSubContractsMPP", @"WSSearchSubContractsMPPResponse", @"WSSubContractsByCollectiveContractMPP", @"WSSubContractsByCollectiveContractMPPResponse", @"WSContractByMemberPOS", @"WSContractByMemberPOSResponse", @"WSMembersByContractCodePOS", @"WSMembersByContractCodePOSResponse", @"WSMemberInformationByContractCodePOS", @"WSMemberInformationByContractCodePOSResponse", @"WSCollectiveContractsByEmployerMPP", @"WSCollectiveContractsByEmployerMPPResponse", @"WSMembersByEmployerPOS", 
@"WSMembersByEmployerPOSResponse", @"WSFindContractByCodeMPP", @"WSFindContractByCodeMPPResponse", @"WSContractAccountStateHeaderMPP", @"WSContractAccountStateHeaderMPPResponse", @"WSContractAccountStateDetailsMPP", @"WSContractAccountStateDetailsMPPResponse", @"WSContractAccountStateFooterMPP", @"WSContractAccountStateFooterMPPResponse", @"WSIPSCapitaInformation", @"WSIPSCapitaInformationResponse", @"WSInvoiceInformationMPP", @"WSInvoiceInformationMPPResponse", @"WSInvoiceInformationDetailMPP", 
@"WSInvoiceInformationDetailMPPResponse", @"WSContractYearsByClientMPP", @"WSContractYearsByClientMPPResponse", @"WSContractsByYearMPP", @"WSContractsByYearMPPResponse", @"WSRetentionCertificateByContractMPP", @"WSRetentionCertificateByContractMPPResponse", @"WSRetentionCertificateByContractDetailMPP", @"WSRetentionCertificateByContractDetailMPPResponse", @"WSFindContractsByMemberDocumentMPP", @"WSFindContractsByMemberDocumentMPPResponse", @"WSContractYearsByContractMPP", @"WSContractYearsByContractMPPResponse", 
@"WSPaymentYearsByMemberPOS", @"WSPaymentYearsByMemberPOSResponse", @"WSEmployersByMemberPOS", @"WSEmployersByMemberPOSResponse", @"WSPaymentYearsByEmployerMemberPOS", @"WSPaymentYearsByEmployerMemberPOSResponse", @"WSPaymentCertificateHeaderPOS", @"WSPaymentCertificateHeaderPOSResponse", @"WSPaymentCertificateDetailForUPCPOS", @"WSPaymentCertificateDetailForUPCPOSResponse", @"WSPaymentCertificateDetailPOS", @"WSPaymentCertificateDetailPOSResponse", @"WSNoveltyOrNoteDetailMPP", @"WSNoveltyOrNoteDetailMPPResponse", 
@"WSPersonOrInstitutionExists", @"WSPersonOrInstitutionExistsResponse", @"WSPortfolioBalanceByMemberDocumentAndProduct", @"WSPortfolioBalanceByMemberDocumentAndProductResponse", @"WSIncentivesAdministrationSystem", @"WSIncentivesAdministrationSystemResponse"})]
    public sealed class Service_beyondhealth_WebServices : Microsoft.XLANGs.BaseTypes.SchemaBase {
        
        [System.NonSerializedAttribute()]
        private static object _rawSchema;
        
        [System.NonSerializedAttribute()]
        private const string _strSchema = @"<?xml version=""1.0"" encoding=""utf-16""?>
<xs:schema xmlns:b=""http://schemas.microsoft.com/BizTalk/2003"" xmlns:tns=""http://BeyondHealth/WebServices"" elementFormDefault=""qualified"" targetNamespace=""http://BeyondHealth/WebServices"" xmlns:xs=""http://www.w3.org/2001/XMLSchema"">
  <xs:element name=""WSContractsByMemberMPP"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocumentType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocument"" type=""xs:string"" />
        <xs:element minOccurs=""1"" maxOccurs=""1"" name=""booIncludeOldContracts"" type=""xs:boolean"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""numProduct"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSContractsByMemberMPPResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSContractsByMemberMPPResult"">
          <xs:complexType>
            <xs:sequence>
              <xs:any />
              <xs:any />
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSMembersByContractCodeMPP"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strContractCode"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""numProduct"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSMembersByContractCodeMPPResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSMembersByContractCodeMPPResult"">
          <xs:complexType>
            <xs:sequence>
              <xs:any />
              <xs:any />
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSMembersByContractApplicationCodeMPP"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strContractApplicationCode"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSMembersByContractApplicationCodeMPPResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSMembersByContractApplicationCodeMPPResult"">
          <xs:complexType>
            <xs:sequence>
              <xs:any />
              <xs:any />
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSMemberInformationByContractCodeMPP"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strContractCode"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocumentType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocument"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""numProduct"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSMemberInformationByContractCodeMPPResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSMemberInformationByContractCodeMPPResult"" type=""tns:ServiceMPPMember"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:complexType name=""ServiceMPPMember"">
    <xs:sequence>
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""IdentificationType"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""IdentificationNumber"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""FirstName"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""MiddleName"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""LastName"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""MotherName"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""BirthDate"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""Age"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""Gender"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""RelationShip"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""CivilState"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""City"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""EPS"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""StartDate"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""EndDate"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""PlanType"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""PaymentFrecuency"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""ResetDate"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""AntiquityDate"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""Id"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""MobilePhone"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""EMail"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""CorrespondenceAddress"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""CityCorrespondenceAddress"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""ResidenceAddress"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""CityResidenceAddress"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WorkAddress"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""CityWorkAddress"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""ResidencePhone"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WorkPhone"" type=""xs:string"" />
    </xs:sequence>
  </xs:complexType>
  <xs:element name=""WSMemberInformationByContractApplicationCodeMPP"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strContractApplicationCode"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocumentType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocument"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSMemberInformationByContractApplicationCodeMPPResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSMemberInformationByContractApplicationCodeMPPResult"" type=""tns:ServiceMPPMember"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSCollectiveContractsByIntermediaryMPP"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strIdentificationType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strIdentificationNumber"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strCollectiveType"" type=""xs:string"" />
        <xs:element minOccurs=""1"" maxOccurs=""1"" name=""booIsValid"" type=""xs:boolean"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""numProduct"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSCollectiveContractsByIntermediaryMPPResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSCollectiveContractsByIntermediaryMPPResult"">
          <xs:complexType>
            <xs:sequence>
              <xs:any />
              <xs:any />
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSSearchSubContractsMPP"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strCollectiveType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strKey"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strLastName"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strFirstName"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strIdentificationType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strIdentificationNumber"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strContractCode"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strFatherContractCode"" type=""xs:string"" />
        <xs:element minOccurs=""1"" maxOccurs=""1"" name=""booIsValid"" type=""xs:boolean"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""numProduct"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSSearchSubContractsMPPResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSSearchSubContractsMPPResult"">
          <xs:complexType>
            <xs:sequence>
              <xs:any />
              <xs:any />
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSSubContractsByCollectiveContractMPP"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strCollectiveType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strContractCode"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""numProduct"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSSubContractsByCollectiveContractMPPResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSSubContractsByCollectiveContractMPPResult"">
          <xs:complexType>
            <xs:sequence>
              <xs:any />
              <xs:any />
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSContractByMemberPOS"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocumentType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocument"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSContractByMemberPOSResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSContractByMemberPOSResult"" type=""tns:ServicePOSContractBE"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:complexType name=""ServicePOSContractBE"">
    <xs:sequence>
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""Id"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""ContractCode"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""EstablishmentDate"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""StartDate"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""EndDate"" type=""xs:string"" />
    </xs:sequence>
  </xs:complexType>
  <xs:element name=""WSMembersByContractCodePOS"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strContractCode"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSMembersByContractCodePOSResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSMembersByContractCodePOSResult"">
          <xs:complexType>
            <xs:sequence>
              <xs:any />
              <xs:any />
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSMemberInformationByContractCodePOS"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strContractCode"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocumentType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocument"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSMemberInformationByContractCodePOSResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSMemberInformationByContractCodePOSResult"" type=""tns:ServicePOSMemberBE"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:complexType name=""ServicePOSMemberBE"">
    <xs:sequence>
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""IdentificationType"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""IdentificationNumber"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""FirstName"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""MiddleName"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""LastName"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""MotherName"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""BirthDate"" type=""xs:string"" />
      <xs:element minOccurs=""1"" maxOccurs=""1"" name=""BirthDateInDateTimeFormat"" type=""xs:dateTime"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""Age"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""Gender"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""RelationShip"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""CivilState"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""City"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""MIPS"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""OIPS"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""StartDate"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""EndDate"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""AccumulatedWeeks"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""PayRange"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""BDUAState"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""UserType"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""EmployerCode"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""EmployerIdentificationNumber"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""EmployerName"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""EmployerIdentificationNumber2"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""EmployerName2"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""EmployerIdentificationNumber3"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""EmployerName3"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""ReceiveType"" type=""xs:string"" />
      <xs:element minOccurs=""1"" maxOccurs=""1"" name=""ValidJob"" type=""xs:boolean"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""ReceiveState"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""ContractState"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""ModeratedQuotaValue"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""ServicePeriod"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""MemberCode"" type=""xs:string"" />
    </xs:sequence>
  </xs:complexType>
  <xs:element name=""WSCollectiveContractsByEmployerMPP"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocumentType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocument"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSCollectiveContractsByEmployerMPPResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSCollectiveContractsByEmployerMPPResult"">
          <xs:complexType>
            <xs:sequence>
              <xs:any />
              <xs:any />
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSMembersByEmployerPOS"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocumentType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocument"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSMembersByEmployerPOSResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSMembersByEmployerPOSResult"">
          <xs:complexType>
            <xs:sequence>
              <xs:any />
              <xs:any />
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSFindContractByCodeMPP"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strContractType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strContractCode"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""numProduct"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSFindContractByCodeMPPResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSFindContractByCodeMPPResult"" type=""tns:ServiceMPPContractBE"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:complexType name=""ServiceMPPContractBE"">
    <xs:sequence>
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""Id"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""ContractCode"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""EstablishmentDate"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""StartDate"" type=""xs:string"" />
    </xs:sequence>
  </xs:complexType>
  <xs:element name=""WSContractAccountStateHeaderMPP"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strContractType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strContractCode"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSContractAccountStateHeaderMPPResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSContractAccountStateHeaderMPPResult"" type=""tns:ServiceContractAccountStateMPPBE"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:complexType name=""ServiceContractAccountStateMPPBE"">
    <xs:sequence>
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""LastInvoiceDate"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""ContractCode"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""State"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""Intemediate"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""IntermediateKey"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""AffiliationContractOwnerName"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""PaymentFrecuency"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""EstablishmentDate"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""StartDate"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""RenewalDate"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""TotalDiscount"" type=""xs:string"" />
    </xs:sequence>
  </xs:complexType>
  <xs:element name=""WSContractAccountStateDetailsMPP"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strContractCode"" type=""xs:string"" />
        <xs:element minOccurs=""1"" maxOccurs=""1"" name=""datInitialDate"" type=""xs:dateTime"" />
        <xs:element minOccurs=""1"" maxOccurs=""1"" name=""datFinalDate"" type=""xs:dateTime"" />
        <xs:element minOccurs=""1"" maxOccurs=""1"" name=""numProductId"" type=""xs:int"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSContractAccountStateDetailsMPPResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSContractAccountStateDetailsMPPResult"">
          <xs:complexType>
            <xs:sequence>
              <xs:any />
              <xs:any />
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSContractAccountStateFooterMPP"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strContractCode"" type=""xs:string"" />
        <xs:element minOccurs=""1"" maxOccurs=""1"" name=""datInitialDate"" type=""xs:dateTime"" />
        <xs:element minOccurs=""1"" maxOccurs=""1"" name=""datFinalDate"" type=""xs:dateTime"" />
        <xs:element minOccurs=""1"" maxOccurs=""1"" name=""numProductId"" type=""xs:int"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSContractAccountStateFooterMPPResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSContractAccountStateFooterMPPResult"">
          <xs:complexType>
            <xs:sequence>
              <xs:any />
              <xs:any />
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSIPSCapitaInformation"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocumentType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocument"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSIPSCapitaInformationResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""1"" maxOccurs=""1"" name=""WSIPSCapitaInformationResult"" type=""xs:boolean"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSInvoiceInformationMPP"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocumentType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocument"" type=""xs:string"" />
        <xs:element minOccurs=""1"" maxOccurs=""1"" name=""booLastInvoice"" type=""xs:boolean"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strContractCode"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSInvoiceInformationMPPResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSInvoiceInformationMPPResult"" type=""tns:ServiceInvoiceInformation"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:complexType name=""ServiceInvoiceInformation"">
    <xs:sequence>
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""IdentificationType"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""IdentificationNumber"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""FirstName"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""Plan"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""MiddleName"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""LastName"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""MotherName"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""ContractNumber"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""IssueDate"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""InvoiceCode"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""CheckDate"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""StartDate"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""EndDate"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""InvoicePeriod"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""ContractType"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""UserNumber"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""PaymentMethod"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""PaymentFrecuency"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""LastCollectDate"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""LastCollectValue"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""LastCollectState"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""ValidityDate"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""PositiveBalance"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""NegativeBalance"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""SubTotalValue"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""NetTotalValue"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""TaxValue"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""TaxPercentage"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""TotalInvoiceValue"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""LastInvoiceBalance"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""TotalPayValue"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""TotalPayValueText"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""CommercialDirectorName"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""CommercialDirectorPhone"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""IntermediateName"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""IntermediatePhone"" type=""xs:string"" />
      <xs:element minOccurs=""1"" maxOccurs=""1"" name=""InvoiceDatabaseCode"" type=""xs:int"" />
      <xs:element minOccurs=""1"" maxOccurs=""1"" name=""AffiliationContractCode"" type=""xs:int"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""ContractPhone"" type=""xs:string"" />
    </xs:sequence>
  </xs:complexType>
  <xs:element name=""WSInvoiceInformationDetailMPP"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strInvoiceCode"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSInvoiceInformationDetailMPPResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSInvoiceInformationDetailMPPResult"">
          <xs:complexType>
            <xs:sequence>
              <xs:any />
              <xs:any />
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSContractYearsByClientMPP"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocumentType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocument"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSContractYearsByClientMPPResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSContractYearsByClientMPPResult"">
          <xs:complexType>
            <xs:sequence>
              <xs:any />
              <xs:any />
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSContractsByYearMPP"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocumentType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocument"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strYear"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSContractsByYearMPPResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSContractsByYearMPPResult"">
          <xs:complexType>
            <xs:sequence>
              <xs:any />
              <xs:any />
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSRetentionCertificateByContractMPP"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strContractType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strContractCode"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strYear"" type=""xs:string"" />
        <xs:element minOccurs=""1"" maxOccurs=""1"" name=""percent"" type=""xs:decimal"" />
        <xs:element minOccurs=""1"" maxOccurs=""1"" name=""boolIsIntermediary"" type=""xs:boolean"" />
        <xs:element minOccurs=""1"" maxOccurs=""1"" name=""numIdentificationType"" type=""xs:int"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strIdentificationNumber"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""numProduct"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSRetentionCertificateByContractMPPResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSRetentionCertificateByContractMPPResult"" type=""tns:ServiceRetentionCertificateBE"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:complexType name=""ServiceRetentionCertificateBE"">
    <xs:sequence>
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""Year"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""Name"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""IdentificationType"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""IdentificationNumber"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""SubName"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""SubIdentificationType"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""SubIdentificationNumber"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""AnnuityPayment"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""AnnuityPaymentText"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""ContractCode"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""CTY_CNAME"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""BRA_CAPPLICATIONCODE"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""INT_CKEY"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""INT_CINTERMEDIARY_NAME"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""INT_CINTERMEDIARY_NAME1"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""PFR_CDESCRIPTION"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""MEMBER"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""REL_CDESCRIPTION"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""StartDate"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""EndDate"" type=""xs:string"" />
      <xs:element minOccurs=""1"" maxOccurs=""1"" name=""QUOTAADMON"" type=""xs:decimal"" />
      <xs:element minOccurs=""1"" maxOccurs=""1"" name=""QUOTAINSCR"" type=""xs:decimal"" />
      <xs:element minOccurs=""1"" maxOccurs=""1"" name=""ANNUITYVALUE"" type=""xs:decimal"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""ANNUITYVALUEText"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""LETTER_GENERATION_DAY"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""LETTER_GENERATION_MONTH"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""LETTER_GENERATION_YEAR"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""LETTER_ANNUITYCONTRACTVALUE"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""EMPLOYER_NAME"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""ITY_CSHORTNAME"" type=""xs:string"" />
    </xs:sequence>
  </xs:complexType>
  <xs:element name=""WSRetentionCertificateByContractDetailMPP"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strContractType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strContractCode"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strYear"" type=""xs:string"" />
        <xs:element minOccurs=""1"" maxOccurs=""1"" name=""boolIsIntermediary"" type=""xs:boolean"" />
        <xs:element minOccurs=""1"" maxOccurs=""1"" name=""numIdentificationType"" type=""xs:int"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strIdentificationNumber"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""numProduct"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSRetentionCertificateByContractDetailMPPResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSRetentionCertificateByContractDetailMPPResult"">
          <xs:complexType>
            <xs:sequence>
              <xs:any />
              <xs:any />
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSFindContractsByMemberDocumentMPP"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocumentType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocument"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strInterDocumentType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strInterDocument"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""numProduct"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSFindContractsByMemberDocumentMPPResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSFindContractsByMemberDocumentMPPResult"">
          <xs:complexType>
            <xs:sequence>
              <xs:any />
              <xs:any />
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSContractYearsByContractMPP"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strContractCode"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSContractYearsByContractMPPResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSContractYearsByContractMPPResult"">
          <xs:complexType>
            <xs:sequence>
              <xs:any />
              <xs:any />
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSPaymentYearsByMemberPOS"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocumentType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocument"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strPaymentType"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSPaymentYearsByMemberPOSResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSPaymentYearsByMemberPOSResult"">
          <xs:complexType>
            <xs:sequence>
              <xs:any />
              <xs:any />
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSEmployersByMemberPOS"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocumentType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocument"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSEmployersByMemberPOSResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSEmployersByMemberPOSResult"">
          <xs:complexType>
            <xs:sequence>
              <xs:any />
              <xs:any />
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSPaymentYearsByEmployerMemberPOS"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strMemberDocumentType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strMemberDocument"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strEmployerDocumentType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strEmployerDocument"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSPaymentYearsByEmployerMemberPOSResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSPaymentYearsByEmployerMemberPOSResult"">
          <xs:complexType>
            <xs:sequence>
              <xs:any />
              <xs:any />
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSPaymentCertificateHeaderPOS"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocumentType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocument"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strPaymentType"" type=""xs:string"" />
        <xs:element minOccurs=""1"" maxOccurs=""1"" name=""datInitialDate"" type=""xs:dateTime"" />
        <xs:element minOccurs=""1"" maxOccurs=""1"" name=""datFinalDate"" type=""xs:dateTime"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSPaymentCertificateHeaderPOSResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSPaymentCertificateHeaderPOSResult"" type=""tns:ServiceCertificateBE"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:complexType name=""ServiceCertificateBE"">
    <xs:sequence>
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""Year"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""Name"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""IdentificationType"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""IdentificationNumber"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""TotalValue"" type=""xs:string"" />
      <xs:element minOccurs=""0"" maxOccurs=""1"" name=""TotalValueText"" type=""xs:string"" />
    </xs:sequence>
  </xs:complexType>
  <xs:element name=""WSPaymentCertificateDetailForUPCPOS"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocumentType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocument"" type=""xs:string"" />
        <xs:element minOccurs=""1"" maxOccurs=""1"" name=""datInitialDate"" type=""xs:dateTime"" />
        <xs:element minOccurs=""1"" maxOccurs=""1"" name=""datFinalDate"" type=""xs:dateTime"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSPaymentCertificateDetailForUPCPOSResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSPaymentCertificateDetailForUPCPOSResult"">
          <xs:complexType>
            <xs:sequence>
              <xs:any />
              <xs:any />
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSPaymentCertificateDetailPOS"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocumentType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocument"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strPaymentType"" type=""xs:string"" />
        <xs:element minOccurs=""1"" maxOccurs=""1"" name=""datInitialDate"" type=""xs:dateTime"" />
        <xs:element minOccurs=""1"" maxOccurs=""1"" name=""datFinalDate"" type=""xs:dateTime"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSPaymentCertificateDetailPOSResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSPaymentCertificateDetailPOSResult"">
          <xs:complexType>
            <xs:sequence>
              <xs:any />
              <xs:any />
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSNoveltyOrNoteDetailMPP"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strContractType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDataType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strContractCode"" type=""xs:string"" />
        <xs:element minOccurs=""1"" maxOccurs=""1"" name=""datInitialDate"" type=""xs:dateTime"" />
        <xs:element minOccurs=""1"" maxOccurs=""1"" name=""datFinalDate"" type=""xs:dateTime"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSNoveltyOrNoteDetailMPPResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSNoveltyOrNoteDetailMPPResult"">
          <xs:complexType>
            <xs:sequence>
              <xs:any />
              <xs:any />
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSPersonOrInstitutionExists"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocumentType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocument"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSPersonOrInstitutionExistsResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""1"" maxOccurs=""1"" name=""WSPersonOrInstitutionExistsResult"" type=""xs:boolean"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSPortfolioBalanceByMemberDocumentAndProduct"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocumentType"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""strDocument"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""numProduct"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSPortfolioBalanceByMemberDocumentAndProductResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSPortfolioBalanceByMemberDocumentAndProductResult"">
          <xs:complexType>
            <xs:sequence>
              <xs:any />
              <xs:any />
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSIncentivesAdministrationSystem"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""1"" maxOccurs=""1"" name=""datInitialDate"" type=""xs:dateTime"" />
        <xs:element minOccurs=""1"" maxOccurs=""1"" name=""datEndingDate"" type=""xs:dateTime"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""WSIncentivesAdministrationSystemResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""WSIncentivesAdministrationSystemResult"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
</xs:schema>";
        
        public Service_beyondhealth_WebServices() {
        }
        
        public override string XmlContent {
            get {
                return _strSchema;
            }
        }
        
        public override string[] RootNodes {
            get {
                string[] _RootElements = new string [72];
                _RootElements[0] = "WSContractsByMemberMPP";
                _RootElements[1] = "WSContractsByMemberMPPResponse";
                _RootElements[2] = "WSMembersByContractCodeMPP";
                _RootElements[3] = "WSMembersByContractCodeMPPResponse";
                _RootElements[4] = "WSMembersByContractApplicationCodeMPP";
                _RootElements[5] = "WSMembersByContractApplicationCodeMPPResponse";
                _RootElements[6] = "WSMemberInformationByContractCodeMPP";
                _RootElements[7] = "WSMemberInformationByContractCodeMPPResponse";
                _RootElements[8] = "WSMemberInformationByContractApplicationCodeMPP";
                _RootElements[9] = "WSMemberInformationByContractApplicationCodeMPPResponse";
                _RootElements[10] = "WSCollectiveContractsByIntermediaryMPP";
                _RootElements[11] = "WSCollectiveContractsByIntermediaryMPPResponse";
                _RootElements[12] = "WSSearchSubContractsMPP";
                _RootElements[13] = "WSSearchSubContractsMPPResponse";
                _RootElements[14] = "WSSubContractsByCollectiveContractMPP";
                _RootElements[15] = "WSSubContractsByCollectiveContractMPPResponse";
                _RootElements[16] = "WSContractByMemberPOS";
                _RootElements[17] = "WSContractByMemberPOSResponse";
                _RootElements[18] = "WSMembersByContractCodePOS";
                _RootElements[19] = "WSMembersByContractCodePOSResponse";
                _RootElements[20] = "WSMemberInformationByContractCodePOS";
                _RootElements[21] = "WSMemberInformationByContractCodePOSResponse";
                _RootElements[22] = "WSCollectiveContractsByEmployerMPP";
                _RootElements[23] = "WSCollectiveContractsByEmployerMPPResponse";
                _RootElements[24] = "WSMembersByEmployerPOS";
                _RootElements[25] = "WSMembersByEmployerPOSResponse";
                _RootElements[26] = "WSFindContractByCodeMPP";
                _RootElements[27] = "WSFindContractByCodeMPPResponse";
                _RootElements[28] = "WSContractAccountStateHeaderMPP";
                _RootElements[29] = "WSContractAccountStateHeaderMPPResponse";
                _RootElements[30] = "WSContractAccountStateDetailsMPP";
                _RootElements[31] = "WSContractAccountStateDetailsMPPResponse";
                _RootElements[32] = "WSContractAccountStateFooterMPP";
                _RootElements[33] = "WSContractAccountStateFooterMPPResponse";
                _RootElements[34] = "WSIPSCapitaInformation";
                _RootElements[35] = "WSIPSCapitaInformationResponse";
                _RootElements[36] = "WSInvoiceInformationMPP";
                _RootElements[37] = "WSInvoiceInformationMPPResponse";
                _RootElements[38] = "WSInvoiceInformationDetailMPP";
                _RootElements[39] = "WSInvoiceInformationDetailMPPResponse";
                _RootElements[40] = "WSContractYearsByClientMPP";
                _RootElements[41] = "WSContractYearsByClientMPPResponse";
                _RootElements[42] = "WSContractsByYearMPP";
                _RootElements[43] = "WSContractsByYearMPPResponse";
                _RootElements[44] = "WSRetentionCertificateByContractMPP";
                _RootElements[45] = "WSRetentionCertificateByContractMPPResponse";
                _RootElements[46] = "WSRetentionCertificateByContractDetailMPP";
                _RootElements[47] = "WSRetentionCertificateByContractDetailMPPResponse";
                _RootElements[48] = "WSFindContractsByMemberDocumentMPP";
                _RootElements[49] = "WSFindContractsByMemberDocumentMPPResponse";
                _RootElements[50] = "WSContractYearsByContractMPP";
                _RootElements[51] = "WSContractYearsByContractMPPResponse";
                _RootElements[52] = "WSPaymentYearsByMemberPOS";
                _RootElements[53] = "WSPaymentYearsByMemberPOSResponse";
                _RootElements[54] = "WSEmployersByMemberPOS";
                _RootElements[55] = "WSEmployersByMemberPOSResponse";
                _RootElements[56] = "WSPaymentYearsByEmployerMemberPOS";
                _RootElements[57] = "WSPaymentYearsByEmployerMemberPOSResponse";
                _RootElements[58] = "WSPaymentCertificateHeaderPOS";
                _RootElements[59] = "WSPaymentCertificateHeaderPOSResponse";
                _RootElements[60] = "WSPaymentCertificateDetailForUPCPOS";
                _RootElements[61] = "WSPaymentCertificateDetailForUPCPOSResponse";
                _RootElements[62] = "WSPaymentCertificateDetailPOS";
                _RootElements[63] = "WSPaymentCertificateDetailPOSResponse";
                _RootElements[64] = "WSNoveltyOrNoteDetailMPP";
                _RootElements[65] = "WSNoveltyOrNoteDetailMPPResponse";
                _RootElements[66] = "WSPersonOrInstitutionExists";
                _RootElements[67] = "WSPersonOrInstitutionExistsResponse";
                _RootElements[68] = "WSPortfolioBalanceByMemberDocumentAndProduct";
                _RootElements[69] = "WSPortfolioBalanceByMemberDocumentAndProductResponse";
                _RootElements[70] = "WSIncentivesAdministrationSystem";
                _RootElements[71] = "WSIncentivesAdministrationSystemResponse";
                return _RootElements;
            }
        }
        
        protected override object RawSchema {
            get {
                return _rawSchema;
            }
            set {
                _rawSchema = value;
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSContractsByMemberMPP")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSContractsByMemberMPP"})]
        public sealed class WSContractsByMemberMPP : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSContractsByMemberMPP() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSContractsByMemberMPP";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSContractsByMemberMPPResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSContractsByMemberMPPResponse"})]
        public sealed class WSContractsByMemberMPPResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSContractsByMemberMPPResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSContractsByMemberMPPResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSMembersByContractCodeMPP")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSMembersByContractCodeMPP"})]
        public sealed class WSMembersByContractCodeMPP : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSMembersByContractCodeMPP() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSMembersByContractCodeMPP";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSMembersByContractCodeMPPResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSMembersByContractCodeMPPResponse"})]
        public sealed class WSMembersByContractCodeMPPResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSMembersByContractCodeMPPResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSMembersByContractCodeMPPResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSMembersByContractApplicationCodeMPP")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSMembersByContractApplicationCodeMPP"})]
        public sealed class WSMembersByContractApplicationCodeMPP : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSMembersByContractApplicationCodeMPP() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSMembersByContractApplicationCodeMPP";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSMembersByContractApplicationCodeMPPResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSMembersByContractApplicationCodeMPPResponse"})]
        public sealed class WSMembersByContractApplicationCodeMPPResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSMembersByContractApplicationCodeMPPResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSMembersByContractApplicationCodeMPPResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSMemberInformationByContractCodeMPP")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSMemberInformationByContractCodeMPP"})]
        public sealed class WSMemberInformationByContractCodeMPP : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSMemberInformationByContractCodeMPP() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSMemberInformationByContractCodeMPP";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSMemberInformationByContractCodeMPPResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSMemberInformationByContractCodeMPPResponse"})]
        public sealed class WSMemberInformationByContractCodeMPPResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSMemberInformationByContractCodeMPPResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSMemberInformationByContractCodeMPPResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSMemberInformationByContractApplicationCodeMPP")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSMemberInformationByContractApplicationCodeMPP"})]
        public sealed class WSMemberInformationByContractApplicationCodeMPP : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSMemberInformationByContractApplicationCodeMPP() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSMemberInformationByContractApplicationCodeMPP";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSMemberInformationByContractApplicationCodeMPPResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSMemberInformationByContractApplicationCodeMPPResponse"})]
        public sealed class WSMemberInformationByContractApplicationCodeMPPResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSMemberInformationByContractApplicationCodeMPPResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSMemberInformationByContractApplicationCodeMPPResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSCollectiveContractsByIntermediaryMPP")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSCollectiveContractsByIntermediaryMPP"})]
        public sealed class WSCollectiveContractsByIntermediaryMPP : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSCollectiveContractsByIntermediaryMPP() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSCollectiveContractsByIntermediaryMPP";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSCollectiveContractsByIntermediaryMPPResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSCollectiveContractsByIntermediaryMPPResponse"})]
        public sealed class WSCollectiveContractsByIntermediaryMPPResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSCollectiveContractsByIntermediaryMPPResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSCollectiveContractsByIntermediaryMPPResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSSearchSubContractsMPP")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSSearchSubContractsMPP"})]
        public sealed class WSSearchSubContractsMPP : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSSearchSubContractsMPP() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSSearchSubContractsMPP";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSSearchSubContractsMPPResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSSearchSubContractsMPPResponse"})]
        public sealed class WSSearchSubContractsMPPResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSSearchSubContractsMPPResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSSearchSubContractsMPPResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSSubContractsByCollectiveContractMPP")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSSubContractsByCollectiveContractMPP"})]
        public sealed class WSSubContractsByCollectiveContractMPP : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSSubContractsByCollectiveContractMPP() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSSubContractsByCollectiveContractMPP";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSSubContractsByCollectiveContractMPPResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSSubContractsByCollectiveContractMPPResponse"})]
        public sealed class WSSubContractsByCollectiveContractMPPResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSSubContractsByCollectiveContractMPPResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSSubContractsByCollectiveContractMPPResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSContractByMemberPOS")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSContractByMemberPOS"})]
        public sealed class WSContractByMemberPOS : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSContractByMemberPOS() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSContractByMemberPOS";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSContractByMemberPOSResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSContractByMemberPOSResponse"})]
        public sealed class WSContractByMemberPOSResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSContractByMemberPOSResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSContractByMemberPOSResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSMembersByContractCodePOS")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSMembersByContractCodePOS"})]
        public sealed class WSMembersByContractCodePOS : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSMembersByContractCodePOS() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSMembersByContractCodePOS";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSMembersByContractCodePOSResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSMembersByContractCodePOSResponse"})]
        public sealed class WSMembersByContractCodePOSResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSMembersByContractCodePOSResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSMembersByContractCodePOSResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSMemberInformationByContractCodePOS")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSMemberInformationByContractCodePOS"})]
        public sealed class WSMemberInformationByContractCodePOS : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSMemberInformationByContractCodePOS() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSMemberInformationByContractCodePOS";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSMemberInformationByContractCodePOSResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSMemberInformationByContractCodePOSResponse"})]
        public sealed class WSMemberInformationByContractCodePOSResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSMemberInformationByContractCodePOSResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSMemberInformationByContractCodePOSResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSCollectiveContractsByEmployerMPP")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSCollectiveContractsByEmployerMPP"})]
        public sealed class WSCollectiveContractsByEmployerMPP : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSCollectiveContractsByEmployerMPP() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSCollectiveContractsByEmployerMPP";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSCollectiveContractsByEmployerMPPResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSCollectiveContractsByEmployerMPPResponse"})]
        public sealed class WSCollectiveContractsByEmployerMPPResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSCollectiveContractsByEmployerMPPResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSCollectiveContractsByEmployerMPPResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSMembersByEmployerPOS")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSMembersByEmployerPOS"})]
        public sealed class WSMembersByEmployerPOS : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSMembersByEmployerPOS() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSMembersByEmployerPOS";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSMembersByEmployerPOSResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSMembersByEmployerPOSResponse"})]
        public sealed class WSMembersByEmployerPOSResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSMembersByEmployerPOSResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSMembersByEmployerPOSResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSFindContractByCodeMPP")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSFindContractByCodeMPP"})]
        public sealed class WSFindContractByCodeMPP : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSFindContractByCodeMPP() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSFindContractByCodeMPP";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSFindContractByCodeMPPResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSFindContractByCodeMPPResponse"})]
        public sealed class WSFindContractByCodeMPPResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSFindContractByCodeMPPResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSFindContractByCodeMPPResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSContractAccountStateHeaderMPP")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSContractAccountStateHeaderMPP"})]
        public sealed class WSContractAccountStateHeaderMPP : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSContractAccountStateHeaderMPP() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSContractAccountStateHeaderMPP";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSContractAccountStateHeaderMPPResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSContractAccountStateHeaderMPPResponse"})]
        public sealed class WSContractAccountStateHeaderMPPResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSContractAccountStateHeaderMPPResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSContractAccountStateHeaderMPPResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSContractAccountStateDetailsMPP")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSContractAccountStateDetailsMPP"})]
        public sealed class WSContractAccountStateDetailsMPP : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSContractAccountStateDetailsMPP() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSContractAccountStateDetailsMPP";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSContractAccountStateDetailsMPPResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSContractAccountStateDetailsMPPResponse"})]
        public sealed class WSContractAccountStateDetailsMPPResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSContractAccountStateDetailsMPPResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSContractAccountStateDetailsMPPResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSContractAccountStateFooterMPP")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSContractAccountStateFooterMPP"})]
        public sealed class WSContractAccountStateFooterMPP : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSContractAccountStateFooterMPP() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSContractAccountStateFooterMPP";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSContractAccountStateFooterMPPResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSContractAccountStateFooterMPPResponse"})]
        public sealed class WSContractAccountStateFooterMPPResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSContractAccountStateFooterMPPResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSContractAccountStateFooterMPPResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSIPSCapitaInformation")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSIPSCapitaInformation"})]
        public sealed class WSIPSCapitaInformation : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSIPSCapitaInformation() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSIPSCapitaInformation";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSIPSCapitaInformationResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSIPSCapitaInformationResponse"})]
        public sealed class WSIPSCapitaInformationResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSIPSCapitaInformationResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSIPSCapitaInformationResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSInvoiceInformationMPP")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSInvoiceInformationMPP"})]
        public sealed class WSInvoiceInformationMPP : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSInvoiceInformationMPP() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSInvoiceInformationMPP";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSInvoiceInformationMPPResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSInvoiceInformationMPPResponse"})]
        public sealed class WSInvoiceInformationMPPResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSInvoiceInformationMPPResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSInvoiceInformationMPPResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSInvoiceInformationDetailMPP")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSInvoiceInformationDetailMPP"})]
        public sealed class WSInvoiceInformationDetailMPP : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSInvoiceInformationDetailMPP() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSInvoiceInformationDetailMPP";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSInvoiceInformationDetailMPPResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSInvoiceInformationDetailMPPResponse"})]
        public sealed class WSInvoiceInformationDetailMPPResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSInvoiceInformationDetailMPPResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSInvoiceInformationDetailMPPResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSContractYearsByClientMPP")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSContractYearsByClientMPP"})]
        public sealed class WSContractYearsByClientMPP : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSContractYearsByClientMPP() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSContractYearsByClientMPP";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSContractYearsByClientMPPResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSContractYearsByClientMPPResponse"})]
        public sealed class WSContractYearsByClientMPPResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSContractYearsByClientMPPResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSContractYearsByClientMPPResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSContractsByYearMPP")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSContractsByYearMPP"})]
        public sealed class WSContractsByYearMPP : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSContractsByYearMPP() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSContractsByYearMPP";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSContractsByYearMPPResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSContractsByYearMPPResponse"})]
        public sealed class WSContractsByYearMPPResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSContractsByYearMPPResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSContractsByYearMPPResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSRetentionCertificateByContractMPP")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSRetentionCertificateByContractMPP"})]
        public sealed class WSRetentionCertificateByContractMPP : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSRetentionCertificateByContractMPP() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSRetentionCertificateByContractMPP";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSRetentionCertificateByContractMPPResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSRetentionCertificateByContractMPPResponse"})]
        public sealed class WSRetentionCertificateByContractMPPResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSRetentionCertificateByContractMPPResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSRetentionCertificateByContractMPPResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSRetentionCertificateByContractDetailMPP")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSRetentionCertificateByContractDetailMPP"})]
        public sealed class WSRetentionCertificateByContractDetailMPP : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSRetentionCertificateByContractDetailMPP() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSRetentionCertificateByContractDetailMPP";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSRetentionCertificateByContractDetailMPPResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSRetentionCertificateByContractDetailMPPResponse"})]
        public sealed class WSRetentionCertificateByContractDetailMPPResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSRetentionCertificateByContractDetailMPPResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSRetentionCertificateByContractDetailMPPResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSFindContractsByMemberDocumentMPP")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSFindContractsByMemberDocumentMPP"})]
        public sealed class WSFindContractsByMemberDocumentMPP : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSFindContractsByMemberDocumentMPP() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSFindContractsByMemberDocumentMPP";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSFindContractsByMemberDocumentMPPResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSFindContractsByMemberDocumentMPPResponse"})]
        public sealed class WSFindContractsByMemberDocumentMPPResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSFindContractsByMemberDocumentMPPResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSFindContractsByMemberDocumentMPPResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSContractYearsByContractMPP")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSContractYearsByContractMPP"})]
        public sealed class WSContractYearsByContractMPP : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSContractYearsByContractMPP() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSContractYearsByContractMPP";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSContractYearsByContractMPPResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSContractYearsByContractMPPResponse"})]
        public sealed class WSContractYearsByContractMPPResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSContractYearsByContractMPPResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSContractYearsByContractMPPResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSPaymentYearsByMemberPOS")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSPaymentYearsByMemberPOS"})]
        public sealed class WSPaymentYearsByMemberPOS : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSPaymentYearsByMemberPOS() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSPaymentYearsByMemberPOS";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSPaymentYearsByMemberPOSResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSPaymentYearsByMemberPOSResponse"})]
        public sealed class WSPaymentYearsByMemberPOSResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSPaymentYearsByMemberPOSResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSPaymentYearsByMemberPOSResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSEmployersByMemberPOS")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSEmployersByMemberPOS"})]
        public sealed class WSEmployersByMemberPOS : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSEmployersByMemberPOS() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSEmployersByMemberPOS";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSEmployersByMemberPOSResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSEmployersByMemberPOSResponse"})]
        public sealed class WSEmployersByMemberPOSResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSEmployersByMemberPOSResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSEmployersByMemberPOSResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSPaymentYearsByEmployerMemberPOS")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSPaymentYearsByEmployerMemberPOS"})]
        public sealed class WSPaymentYearsByEmployerMemberPOS : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSPaymentYearsByEmployerMemberPOS() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSPaymentYearsByEmployerMemberPOS";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSPaymentYearsByEmployerMemberPOSResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSPaymentYearsByEmployerMemberPOSResponse"})]
        public sealed class WSPaymentYearsByEmployerMemberPOSResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSPaymentYearsByEmployerMemberPOSResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSPaymentYearsByEmployerMemberPOSResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSPaymentCertificateHeaderPOS")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSPaymentCertificateHeaderPOS"})]
        public sealed class WSPaymentCertificateHeaderPOS : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSPaymentCertificateHeaderPOS() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSPaymentCertificateHeaderPOS";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSPaymentCertificateHeaderPOSResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSPaymentCertificateHeaderPOSResponse"})]
        public sealed class WSPaymentCertificateHeaderPOSResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSPaymentCertificateHeaderPOSResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSPaymentCertificateHeaderPOSResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSPaymentCertificateDetailForUPCPOS")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSPaymentCertificateDetailForUPCPOS"})]
        public sealed class WSPaymentCertificateDetailForUPCPOS : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSPaymentCertificateDetailForUPCPOS() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSPaymentCertificateDetailForUPCPOS";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSPaymentCertificateDetailForUPCPOSResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSPaymentCertificateDetailForUPCPOSResponse"})]
        public sealed class WSPaymentCertificateDetailForUPCPOSResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSPaymentCertificateDetailForUPCPOSResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSPaymentCertificateDetailForUPCPOSResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSPaymentCertificateDetailPOS")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSPaymentCertificateDetailPOS"})]
        public sealed class WSPaymentCertificateDetailPOS : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSPaymentCertificateDetailPOS() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSPaymentCertificateDetailPOS";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSPaymentCertificateDetailPOSResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSPaymentCertificateDetailPOSResponse"})]
        public sealed class WSPaymentCertificateDetailPOSResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSPaymentCertificateDetailPOSResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSPaymentCertificateDetailPOSResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSNoveltyOrNoteDetailMPP")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSNoveltyOrNoteDetailMPP"})]
        public sealed class WSNoveltyOrNoteDetailMPP : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSNoveltyOrNoteDetailMPP() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSNoveltyOrNoteDetailMPP";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSNoveltyOrNoteDetailMPPResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSNoveltyOrNoteDetailMPPResponse"})]
        public sealed class WSNoveltyOrNoteDetailMPPResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSNoveltyOrNoteDetailMPPResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSNoveltyOrNoteDetailMPPResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSPersonOrInstitutionExists")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSPersonOrInstitutionExists"})]
        public sealed class WSPersonOrInstitutionExists : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSPersonOrInstitutionExists() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSPersonOrInstitutionExists";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSPersonOrInstitutionExistsResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSPersonOrInstitutionExistsResponse"})]
        public sealed class WSPersonOrInstitutionExistsResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSPersonOrInstitutionExistsResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSPersonOrInstitutionExistsResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSPortfolioBalanceByMemberDocumentAndProduct")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSPortfolioBalanceByMemberDocumentAndProduct"})]
        public sealed class WSPortfolioBalanceByMemberDocumentAndProduct : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSPortfolioBalanceByMemberDocumentAndProduct() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSPortfolioBalanceByMemberDocumentAndProduct";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSPortfolioBalanceByMemberDocumentAndProductResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSPortfolioBalanceByMemberDocumentAndProductResponse"})]
        public sealed class WSPortfolioBalanceByMemberDocumentAndProductResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSPortfolioBalanceByMemberDocumentAndProductResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSPortfolioBalanceByMemberDocumentAndProductResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSIncentivesAdministrationSystem")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSIncentivesAdministrationSystem"})]
        public sealed class WSIncentivesAdministrationSystem : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSIncentivesAdministrationSystem() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSIncentivesAdministrationSystem";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://BeyondHealth/WebServices",@"WSIncentivesAdministrationSystemResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"WSIncentivesAdministrationSystemResponse"})]
        public sealed class WSIncentivesAdministrationSystemResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public WSIncentivesAdministrationSystemResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "WSIncentivesAdministrationSystemResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
    }
}
