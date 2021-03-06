package com.cristik.common.shiro.strategy;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.pam.FirstSuccessfulStrategy;
import org.apache.shiro.realm.Realm;

/**
 * Created by zhenghua on 2016/6/1.
 */
public class FirstExceptionStrategy extends FirstSuccessfulStrategy{
    @Override
    public AuthenticationInfo afterAttempt(Realm realm, AuthenticationToken token, AuthenticationInfo singleRealmInfo, AuthenticationInfo aggregateInfo, Throwable t) throws AuthenticationException {
        if ((t != null) && (t instanceof AuthenticationException)) throw (AuthenticationException) t;
        return super.afterAttempt(realm, token, singleRealmInfo, aggregateInfo, t);
    }
}
