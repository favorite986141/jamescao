<%@ Page Language="VB" MasterPageFile="~/MasterPage/Site.master" AutoEventWireup="false" CodeFile="CPassword.aspx.vb" Inherits="SystemSet_CPassword" %>

<%--<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>--%>
    <%--<form id="form1" runat="server">--%>
    <asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <div style="text-align: center;">
            <br />
            <br />
            <br />
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <%--20100630 Albert Modify -- 瀏覽器相容性，IE8、FF、Chrome密碼輸入表單置中問題--%>
                    <div>
                        <table style="width: 60%; margin-left: auto; margin-right: auto" class="Table_CSS shadow Font3">
                            <tr>
                                <td colspan="2" class="Table_Header1">
                                    <asp:Label ID="Lab_CHPW_Title" runat="server" Text="Label"></asp:Label><span style="color: #ff0000">
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 40%;" class="Table_Left_CSS1 Font4">
                                    <span style="color: red">*</span>
                                    <asp:Label ID="Lab_CHPW_OldPw" runat="server" Text="Label"></asp:Label>
                                </td>
                                <td style="width: 60%;" class="Table_Right_CSS1 Font5">
                                    <%--V4.2.0 20220110 Eric Add 密碼顯示/隱藏--%>
                                    <div class="div_pwEyes">
                                        <asp:TextBox ID="TBox_CHPW_OldPw" runat="server" MaxLength="20" TextMode="Password"></asp:TextBox>
                                    </div>
                                    <asp:Label ID="Lab_CHPW_OldPw_Err" runat="server" ForeColor="Red"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 40%;" class="Table_Left_CSS2 Font4">
                                    <span style="color: red">*</span>
                                    <asp:Label ID="Lab_CHPW_NewPw" runat="server" Text="Label"></asp:Label>
                                </td>
                                <td style="width: 60%;" class="Table_Right_CSS2 Font5">
                                    <%--V4.2.0 20220110 Eric Add 密碼顯示/隱藏--%>
                                    <div class="div_pwEyes">
                                        <asp:TextBox ID="TBox_CHPW_NewPw" runat="server" MaxLength="20" TextMode="Password"></asp:TextBox>
                                    </div>
                                    <asp:Label ID="Lab_CHPW_NewPw_Err" runat="server" ForeColor="Red"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 40%;" class="Table_Left_CSS1 Font4">
                                    <span style="color: red">*</span>
                                    <asp:Label ID="Lab_CHPW_ConfNewPw" runat="server" Text="Label"></asp:Label>
                                </td>
                                <td style="width: 60%;" class="Table_Right_CSS1 Font5">
                                    <%--V4.2.0 20220110 Eric Add 密碼顯示/隱藏--%>
                                    <div class="div_pwEyes">
                                        <asp:TextBox ID="TBox_CHPW_ConfNewPw" runat="server" MaxLength="20" TextMode="Password"></asp:TextBox>
                                    </div>
                                    <asp:Label ID="Lab_CHPW_ConfNewPw_Err" runat="server" ForeColor="Red"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" class="Table_BtnRow_CSS">&nbsp;<asp:Button ID="But_CHPW_Save" runat="server" Text="Button" OnClick="But_CHPW_Save_Click" CssClass="" />&nbsp;
                            <asp:Button ID="But_CHPW_Cancel" runat="server" Text="Button" OnClick="But_CHPW_Cancel_Click" CssClass="" />
                                </td>
                            </tr>
                        </table>
                        <table style="width: 60%; margin-left: auto; margin-right: auto" class="Font3">
                            <tr>
                                <td style="text-align: left;">
                                     <asp:Panel ID="Panel_PwdSTRONG_Note" HorizontalAlign="Left" runat="server">
                                        <asp:Label ID="Lab_PwdSTRONG_Note" runat="server" Text="Label"></asp:Label>
                                        <br />
                                        <asp:Label ID="Lab_Link_1" runat="server" Text="Label"></asp:Label>&nbsp;
                                        <asp:Label ID="Lab_PwdSTRONG_Note_1" runat="server" Text="Label"></asp:Label>
                                        <br />
                                        <asp:Label ID="Lab_Link_2" runat="server" Text="Label"></asp:Label>&nbsp;
                                        <asp:Label ID="Lab_PwdSTRONG_Note_2" runat="server" Text="Label"></asp:Label>
                                        <br />
                                        <asp:Label ID="Lab_Link_3" runat="server" Text="Label"></asp:Label>&nbsp;
                                        <asp:Label ID="Lab_PwdSTRONG_Note_3" runat="server" Text="Label"></asp:Label>
                                        <br />
                                        <asp:Label ID="Lab_Link_4" runat="server" Text="Label"></asp:Label>&nbsp;
                                        <asp:Label ID="Lab_PwdSTRONG_Note_4" runat="server" Text="Label"></asp:Label>
                                        <br />
                                        <asp:Label ID="Lab_Link_5" runat="server" Text="Label"></asp:Label>&nbsp;
                                        <asp:Label ID="Lab_PwdSTRONG_Note_5" runat="server" Text="Label"></asp:Label>
                                        <br />
                                    </asp:Panel>
                                    <asp:Label ID="Lab_Link_6" runat="server" Text="Label"></asp:Label>&nbsp;
                                    <asp:Label ID="Lab_PwdSTRONG_Note_6" runat="server" Text="Label"></asp:Label>
                                </td>
                            </tr>
                                              
                        </table> 
                        
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <br />
            <br />
            <br />
        </div>
    <%--</form>--%>
     <%-- //V4.2.0 20220110 Eric Add 密碼顯示/隱藏--%>
    <script type="text/javascript" src="../Lib/JavaScript/JS_CommonFunction.js"></script>
    <script >
        window.onload = function () { AddPWShowHide(); };
    </script>
    </asp:Content>
<%--</body>
</html>--%>
