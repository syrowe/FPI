<%@ Assembly Name="FPI, Version=1.0.0.0, Culture=neutral, PublicKeyToken=2e092737738f74c2" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="VB" AutoEventWireup="true" CodeBehind="Sent.aspx.vb" Inherits="FPI.Layouts.FPI.Sent" DynamicMasterPageFile="~masterurl/default.master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
<link rel="Stylesheet" type="text/css" href="/_layouts/ML_Webparts/scripts/Styles.css" />
<script type="text/javascript">

    function SelectAllCheckboxes(spanChk) {

        // Added as ASPX uses SPAN for checkbox
        var oItem = spanChk.children;
        var theBox = (spanChk.type == "checkbox") ?
        spanChk : spanChk.children.item[0];
        xState = theBox.checked;
        elm = theBox.form.elements;

        for (i = 0; i < elm.length; i++)
            if (elm[i].type == "checkbox" &&
              elm[i].id != theBox.id) {
                //elm[i].click();
                if (elm[i].checked != xState)
                    elm[i].click();
                //elm[i].checked=xState;
            }
    }
</script>

</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <asp:DropDownList ID="ManagerDDL" AutoPostBack="true" CssClass="input" AppendDataBoundItems="true" runat="server" DataSourceID="ManagerSQL" DataTextField="Manager" DataValueField="Manager">
        <asp:ListItem></asp:ListItem>
    </asp:DropDownList>
    <asp:TextBox ID="DateTB" runat="server" CssClass="input"></asp:TextBox>
    <cc1:CalendarExtender ID="DateTBExt" TargetControlID="DateTB" format="dd/MM/yyyy" runat="server">
    </cc1:CalendarExtender>
    <asp:GridView ID="FPIGv" runat="server" DataSourceID="FPISQL" AutoGenerateColumns="false" DataKeyNames="ID" CssClass="bordered" >
        <Columns>
            <asp:TemplateField HeaderText="Clientcode" >
                <ItemTemplate>
                    <asp:HyperLink ID="Codehyper" runat="server" Text='<%# Eval("clientcode") %>' NavigateUrl='<%# Eval("clientcode", "/sites/mlintranet/_Layouts/ML_Webparts/Client.aspx?Clientcode={0}") %>'></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="lead_name" SortExpression="lead_name" HeaderText="Name" ReadOnly="true" />
            <asp:TemplateField HeaderText="Sent" >
                <HeaderTemplate>
                <asp:Label ID="sentlbl" runat="server" Text="Select All"></asp:Label>
                  <input id="chkAll" onclick="javascript:SelectAllCheckboxes(this);" 
                              runat="server" type="checkbox" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="ReviewCheck" runat="server" Enabled="true" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:Button ID="ReviewBtn" runat="server" Text="Confirm Sent" />
    <asp:Label ID="errorlbl" runat="server" Text=""></asp:Label>
    <asp:SqlDataSource ID="EntitySql" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ML_DataConnectionString %>" 
        SelectCommand="ICAF_EntityTypes" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="FPISQL" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ML_DataConnectionString %>" 
        OldValuesParameterFormatString="original_{0}" ConflictDetection="OverwriteChanges"
        SelectCommand="Select ID, Clientcode, Lead_Name, manager, modified_user_id from FPIView where datesent is null and manager=@manager" SelectCommandType="Text"
        UpdateCommand="set dateformat dmy Update FPIView set datesent=@date, modified_user_id=@user where id=@ID">
    <UpdateParameters>
        <asp:ControlParameter Name="user" ControlID="userlbl" PropertyName="Text" Type="String" />
        <asp:ControlParameter Name="date" ControlID="DateTB" PropertyName="Text" Type="String" />
        <asp:Parameter Name="ID" Type="String" />
    </UpdateParameters>
    <SelectParameters>
	    <asp:ControlParameter Name="manager" ControlID="ManagerDDL" PropertyName="SelectedValue" Type="String" />
    </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="ManagerSql" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ML_DataConnectionString %>" 
        SelectCommand="Select Distinct manager from FPIView where datesent is null" SelectCommandType="Text">
    </asp:SqlDataSource>
        <br />
    <asp:Label ID="UserLbl" runat="server" Text="" Visible="false"></asp:Label>
    
</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
Confirm Sent
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
Confirm Sent
</asp:Content>
