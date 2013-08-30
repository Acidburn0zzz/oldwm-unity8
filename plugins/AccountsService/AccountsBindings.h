/*
 * Copyright (C) 2012,2013 Canonical, Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Authors: Michael Terry <michael.terry@canonical.com>
 */

#ifndef UNITY_ACCOUNTSBINDINGS_H
#define UNITY_ACCOUNTSBINDINGS_H

#include <QObject>
#include <QString>

class AccountsService;

class AccountsBindings: public QObject
{
    Q_OBJECT
    Q_PROPERTY (bool demoEdges
                READ getDemoEdges
                WRITE setDemoEdges
                NOTIFY demoEdgesChanged)
    Q_PROPERTY (QString backgroundFile
                READ getBackgroundFile
                NOTIFY backgroundFileChanged)

public:
    explicit AccountsBindings(QObject *parent = 0);

    Q_INVOKABLE void setUser(const QString &user);

    bool getDemoEdges();
    void setDemoEdges(bool demoEdges);
    Q_INVOKABLE bool getDemoEdgesForUser(const QString &user);
    Q_INVOKABLE void setDemoEdgesForUser(const QString &user, bool demoEdges);

    QString getBackgroundFile();

Q_SIGNALS:
    void demoEdgesChanged();
    void backgroundFileChanged();

private Q_SLOTS:
    void propertiesChanged(const QString &user, const QString &interface, const QStringList &changed);
    void maybeChanged(const QString &user);

private:
    void updateDemoEdges();
    void updateBackgroundFile();

    AccountsService *m_service;
    QString m_user;
    bool m_demoEdges;
    QString m_backgroundFile;
};

#endif
