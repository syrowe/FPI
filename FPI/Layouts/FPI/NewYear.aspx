<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="VB" AutoEventWireup="true" CodeBehind="NewYear.aspx.vb" Inherits="FPI.Layouts.NewYear" DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">

</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <p>Input the next FPI Year in the format <em>Y</em>XXZZ, where the XX and ZZ denote the beginning and end years for that tax year.</p>
    <p>For example the current setting is <em><asp:Label ID="FPIYearlbl" runat="server" Text=""></asp:Label></em></p>
    <br />
    <br />
    <asp:TextBox ID="FPITb" runat="server"></asp:TextBox>
    <br />
    <br />
    <asp:Button ID="SubmitBtn" runat="server" Text="Submit" Visible="false" />
    <asp:SqlDataSource ID="FPISql" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ML_DataConnectionString %>" 
        SelectCommand="Select value from settings where parameter='FPIYear'" SelectCommandType="Text"
        UpdateCommand="FPI_ChangeYear" UpdateCommandType="StoredProcedure" >
        <UpdateParameters>
            <asp:ControlParameter ControlID="FPITb" Name="newyear" PropertyName="Text" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="PermittedSQL" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ML_DataConnectionString %>"
        SelectCommand="Select count(parameter) as permitted from settings where parameter='FPIAdmin' and value like '%' + @user + '%'" >
        <SelectParameters>
            <asp:ControlParameter Name="user" Type="string" ControlID="UserLbl" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="Userlbl" runat="server" Text="Label"></asp:Label>
</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
New FPI Year
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
New FPI Year
</asp:Content>
