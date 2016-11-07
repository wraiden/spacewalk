/**
 * Copyright (c) 2009--2012 Red Hat, Inc.
 *
 * This software is licensed to you under the GNU General Public License,
 * version 2 (GPLv2). There is NO WARRANTY for this software, express or
 * implied, including the implied warranties of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. You should have received a copy of GPLv2
 * along with this software; if not, see
 * http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
 *
 * Red Hat trademarks are not licensed under GPLv2. No permission is
 * granted to use or replicate Red Hat trademarks that are incorporated
 * in this software or its documentation.
 */
package com.redhat.rhn.frontend.action.systems;

import com.redhat.rhn.frontend.dto.VirtualSystemOverview;
import com.redhat.rhn.frontend.filter.Matcher;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

/**
 *
 * VirtualSystemsFilterMatcher
 * @version $Rev$
 */
public class VirtualSystemsFilterMatcher implements Matcher {
    private static final Logger LOG = Logger.getLogger(VirtualSystemsFilterMatcher.class);

    /**
     *
     * {@inheritDoc}
     */
    public boolean include(Object obj,
                                String filterData,
                                String filterColumn) {
        if (StringUtils.isBlank(filterData) ||
                StringUtils.isBlank(filterColumn)) {
            return true; ///show all if I entered a blank value
        }
        VirtualSystemOverview current = (VirtualSystemOverview) obj;
        LOG.error("RESULT: " + current.getName() + "   " + current.getId() + "  " +
                current.getServerName());
        String value = "";
        if (current.getIsVirtualHost()) {
            value = current.getServerName();
        }
        else if (current.getVirtualSystemId() == null) {
            value = current.getName();
        }
        else {
            value = current.getServerName();
        }
        if (!StringUtils.isBlank(value)) {
            return value.toUpperCase().indexOf(filterData.toUpperCase()) >= 0;
        }
        return false;
    }
}
