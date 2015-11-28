<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="afn" uri="/WEB-INF/functions/authz" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include-internal.jsp" %>

<%--@elvariable id="healthStatusItem" type="jetbrains.buildServer.serverSide.healthStatus.HealthStatusItem"--%>
<%--@elvariable id="pluginResourcesPath" type="java.lang.String"--%>
<c:set var="Type" value="${healthStatusItem.additionalData['Type']}"/>
<c:set var="Id" value="${healthStatusItem.additionalData['Id']}"/>

<c:set var="GitHubInfo" value="${healthStatusItem.additionalData['GitHubInfo']}"/>
<c:set var="VcsRoot" value="${healthStatusItem.additionalData['VcsRoot']}"/>
<c:set var="VcsRootInstance" value="${healthStatusItem.additionalData['VcsRootInstance']}"/>
<%--@elvariable id="Type" type="java.lang.String"--%>
<%--@elvariable id="Id" type="java.lang.String"--%>
<%--@elvariable id="GitHubInfo" type="org.jetbrains.teamcity.github.VcsRootGitHubInfo"--%>
<%--@elvariable id="VcsRoot" type="jetbrains.buildServer.vcs.SVcsRoot"--%>
<%--@elvariable id="VcsRootInstance" type="jetbrains.buildServer.vcs.VcsRootInstance"--%>

<%--VcsRootInstance is null when type is not 'Instance'--%>

<c:set var="Identifier" value="${Type}_${Id}"/>


<div id='hid_${Identifier}' class="suggestionItem">
    Found GitHub git VCS root which not using WebHooks:
    <admin:vcsRootName vcsRoot="${VcsRoot}" editingScope="editProject:${VcsRoot.project.externalId}" cameFromUrl="${pageUrl}"/>
    belongs to <admin:projectName project="${VcsRoot.project}"/>
    <div class="suggestionAction">
        <a href="#" class="addNew" onclick="BS.GitHubWebHooks.addWebHook('${Type}', '${Id}'); return false">Add WebHook</a>
        <%--<forms:button className="btn_mini" onclick="BS.GitHubWebHooks.addWebHook('${Type}', '${Id}'); return false">Add WebHook</forms:button>--%>
    </div>
</div>

<script type="text/javascript">
    (function () {
        if (typeof BS.GitHubWebHooks === 'undefined') {
            $j('#hid_${Identifier}').append("<script type='text/javascript' src='<c:url value="${pluginResourcesPath}gh-webhook.js"/>'/>");
        }
    })();
    BS.GitHubWebHooks.info['${Identifier}'] = {"info":${GitHubInfo.toJson()}};
</script>