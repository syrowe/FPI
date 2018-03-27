<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="VB" AutoEventWireup="true" CodeBehind="Embargo.aspx.vb" Inherits="FPI.Layouts.FPI.Embargo" DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">

</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <table>
        
        <tr valign="top">
            <td>
                <asp:Label ID="Label2" runat="server" Text="Provide reason for embargo: "></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="EmbargoTb" runat="server" height="200px" width="200px" textmode="multiline"></asp:TextBox><asp:Label runat="server" ID="errorlbl" Font-Bold="true" ForeColor="Red"></asp:Label>
            </td>
        </tr>
    </table>
    <p>Be aware that if this client is the lead client of the group the group will be disbanded</p>
    <p>If an invoice already exists for this client but has not been sent it will be deleted, if it the lead and recalculated if a "sub"</p>
    <asp:Button ID="SubmitBtn" runat="server" Text="Submit" OnClick="SubmitEmbargo" />

    <asp:Label ID="UserLabel" runat="server" Text="" Visible="false"></asp:Label>
    <asp:SqlDataSource ID="FPISql" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ML_DataConnectionString %>"
        UpdateCommand="FPI_Embargo" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:QueryStringParameter Name="Id" Type="String" QueryStringField="id" />
            <asp:ControlParameter Name="Reason" Type="String" ControlID="EmbargoTB" />
            <asp:ControlParameter Name="user" Type="string" ControlID="UserLabel" />
        </UpdateParameters>
    </asp:SqlDataSource>

</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
Embargo
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
Embargo
</asp:Content>
