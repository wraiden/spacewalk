<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://rhn.redhat.com/rhn" prefix="rhn" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://rhn.redhat.com/tags/list" prefix="rl" %>


<html>
<head>
</head>
<body>
<rhn:toolbar base="h1" icon="header-system" imgAlt="system.common.systemAlt"
 helpUrl="">
  <bean:message key="virtuallist.jsp.toolbar"/><!-- ERIC - This need to change to systemlist.jsp.virtualheader ? -->
</rhn:toolbar>

<rl:listset name="systemListSet" legend="system">
  <rhn:csrf />
  <rhn:submitted />
  <rl:list emptykey="virtuallist.jsp.nosystems"
           filter="com.redhat.rhn.frontend.taglibs.list.filters.SystemOverviewFilter">
    <rl:decorator name="PageSizeDecorator"/>
    <rl:decorator name="ElaborationDecorator"/>
    <rl:decorator name="SystemIconDecorator"/>
    <c:if test = "${empty noAddToSsm}">
      <rl:decorator name="AddToSsmDecorator" />
    </c:if>

    <c:if test = "${empty notSelectable}">
      <rl:decorator name="SelectableDecorator"/>
      <rl:selectablecolumn value="${current.systemId}"
                           selected="${current.selected}"
                           disabled="${!current.selectable}"/>
    </c:if>

    <rl:column sortable="false"
               bound="false"
               styleclass="first-column"
               headerkey="virtuallist.jsp.name">
      <c:choose>
        <c:when test="${current.isVirtualHost && current.hostSystemId != 0}">
          <img src="/img/channel_parent_node.gif"/>
          <bean:message key="virtuallist.jsp.host"/>:
          <a href="/rhn/systems/details/Overview.do?sid=${current.hostSystemId}">
            <c:out value="${current.serverName}" escapeXml="true"/>
          </a>
          <bean:message key="virtuallist.jsp.hoststatus" arg0="${current.countActiveInstances}" arg1="${current.countTotalInstances}"/>
          <c:if test="${current.virtEntitlement != null}">
            (<a href="/rhn/systems/details/virtualization/VirtualGuestsList.do?sid=${current.hostSystemId}"><bean:message key="virtuallist.jsp.viewall"/></a>)
          </c:if>
        </c:when>
        <c:when test="${current.isVirtualHost}">
          <img src="/img/channel_parent_node.gif"/>
          <bean:message key="virtuallist.jsp.host"/>:
          <span style="color: #808080">
            <c:out value="${current.serverName}" escapeXml="true"/>
          </span>
        </c:when>
        <c:otherwise>
          <img src="/img/channel_child_node.gif"/>
          <c:choose>
            <c:when test="${current.virtualSystemId == null}">
              <c:out value="${current.name}" escapeXml="true"/>
            </c:when>
            <c:when test="${current.accessible}">
              <a href="/rhn/systems/details/Overview.do?sid=${current.virtualSystemId}">
                <c:out value="${current.serverName}" escapeXml="true"/>
              </a>
            </c:when>
            <c:otherwise>
              <c:out value="${current.serverName}" escapeXml="true"/>
            </c:otherwise>
          </c:choose>
        </c:otherwise>
      </c:choose>
    </rl:column>

    <rl:column headerkey="virtuallist.jsp.updates">
      <c:if test="${!current.isVirtualHost}">
        <c:out value="${current.statusDisplay}" escapeXml="false"/>
      </c:if>
    </rl:column>

    <rl:column headerkey="virtuallist.jsp.state">
      <c:if test="${!current.isVirtualHost}">
        <c:out value="${current.stateName}" escapeXml="true"/>
      </c:if>
    </rl:column>

    <rl:column headerkey="virtuallist.jsp.channel"
               styleclass="last-column">
      <c:if test="${!current.isVirtualHost}">
        <c:choose>
          <c:when test="${current.channelId == null}">
            <bean:message key="none.message"/>
          </c:when>
          <c:when test="${current.subscribable}">
            <c:out value="<a href=\"/rhn/channels/ChannelDetail.do?cid=${current.channelId}\">${current.channelLabels}</a>" escapeXml="false"/>
          </c:when>
          <c:otherwise>
            <c:out value="${current.channelLabels}"/>
          </c:otherwise>
        </c:choose>
      </c:if>
    </rl:column>
  </rl:list>
  <c:if test = "${empty noCsv}">
    <rl:csv dataset="pageList"
            name="systemList"
            exportColumns="name,id,securityErrata,bugErrata,enhancementErrata,outdatedPackages,lastCheckin,entitlementLevel,channelLabels"/>
  </c:if>
</rl:listset>

</body>
</html>
