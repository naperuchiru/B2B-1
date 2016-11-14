<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template"%>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/responsive/nav"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="org-common" tagdir="/WEB-INF/tags/addons/commerceorgaddon/responsive/common"%>
<%@ taglib prefix="company" tagdir="/WEB-INF/tags/addons/commerceorgaddon/responsive/company"%>

<spring:htmlEscape defaultHtmlEscape="true" />

<spring:theme code="text.company.select.action.label" var="selectAction" />
<spring:theme code="text.company.deselect.action.label" var="deselectAction" />
<c:if test="${empty cancelUrl}">
    <c:url value="/my-company/organization-management/manage-users" var="cancelUrl" />
</c:if>
<c:set var="searchUrl" value="${baseUrl}/${action}?user=${ycommerce:encodeUrl(param.user)}&sort=${ycommerce:encodeUrl(searchPageData.pagination.sort)}" />
<jsp:useBean id="sortQueryParams" class="java.util.HashMap" />
<c:set target="${sortQueryParams}" property="user" value="${param.user}" />
<template:page pageTitle="${pageTitle}">
    <div class="account-section">
        <div class="row">
            <div class="col-xs-12 col-sm-6">
                <org-common:headline url="${cancelUrl}" labelKey="text.company.manageusers.${action}.title" />
            </div>
            <div class="account-header-done-btn col-xs-12 col-sm-3 pull-right">
                <org-common:done url="${cancelUrl}" labelKey="text.company.done.button" />
            </div>
        </div>
        <div class="account-section-content">
            <nav:pagination top="true" showTopTotals="false" supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}"
                searchUrl="${searchUrl}" additionalParams="${sortQueryParams}" msgKey="text.company.${action}.page" numberPagesShown="${numberPagesShown}" hideRefineButton="true"/>
            <c:choose>
                <c:when test="${not empty searchPageData.results}">
                    <div class="account-list">
                        <div class="account-cards card-select">
                            <c:forEach items="${searchPageData.results}" var="result">
                                <div id="row-${ycommerce:normalizedCode(result.code)}" class="card col-xs-12 col-sm-6 col-md-4 <c:if test='${result.selected}'>selected</c:if>">
                                    <company:permissionCardDetails permission="${result}" action="${action}" />
                                    <ycommerce:testId code="${action}_actions_label">
                                        <span id="span-${ycommerce:normalizedCode(result.code)}" class="account-cards-actions">
                                            <spring:url value="${baseUrl}/${action}/select/" var="selectUrl" htmlEscape="false">
                                                <spring:param name="user" value="${param.user}" />
                                                <spring:param name="permission" value="${result.code}" />
                                            </spring:url>
                                            <spring:url value="${baseUrl}/${action}/deselect/" var="deselectUrl" htmlEscape="false">
                                                <spring:param name="user" value="${param.user}" />
                                                <spring:param name="permission" value="${result.code}" />
                                            </spring:url>
                                            <c:choose>
                                                <c:when test="${result.selected}">
                                                    <a href="#" url="${deselectUrl}" class="action-links js-deselectLink">
                                                    <span class="glyphicon glyphicon-ok"></span>
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="#" url="${selectUrl}" class="action-links js-selectLink">
                                                    <span class="glyphicon glyphicon-ok"></span>
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </ycommerce:testId>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <spring:theme code="text.company.noentries" />
                </c:otherwise>
            </c:choose>

            <div class="clearfix">
                <div class="accountActions-bottom pull-right col-xs-12 hidden-sm hidden-md hidden-lg">
                    <org-common:done url="${cancelUrl}" labelKey="text.company.done.button" />
                </div>
            </div>

            <nav:pagination top="false" supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}"
            searchUrl="${searchUrl}" additionalParams="${sortQueryParams}" msgKey="text.company.${action}.page" numberPagesShown="${numberPagesShown}" hideRefineButton="true"/>
        </div>
    </div>
    <c:url value="${baseUrl}/${action}" var="actionLink" />
    <script id="enableDisableLinksTemplate" type="text/x-jquery-tmpl">
        {{if selected}}
        <a href="#" url="${actionLink}/deselect/?permission={{= id}}&user=${param.user}" class="action-links js-deselectLink"><span class="glyphicon glyphicon-ok"></span></a>
        {{else}}
        <a href="#" url="${actionLink}/select/?permission={{= id}}&user=${param.user}" class="action-links js-selectLink"><span class="glyphicon glyphicon-ok"></span></a>
        {{/if}}
    </script>
</template:page>