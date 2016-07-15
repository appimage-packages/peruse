#!/usr/bin/env ruby
# frozen_string_literal: true
# 
# Copyright (C) 2016 Scarlett Clark <sgclark@kde.org>
# Copyright (C) 2015-2016 Harald Sitter <sitter@kde.org>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) version 3, or any
# later version accepted by the membership of KDE e.V. (or its
# successor approved by the membership of KDE e.V.), which shall
# act as a proxy defined in Section 6 of version 3 of the license.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library.  If not, see <http://www.gnu.org/licenses/>.
require 'erb'

class Recipe
    class App
        def initialize(name)
            @name = name                
        end
    end
    
    attr_accessor :name
    attr_accessor :proper_name
    attr_accessor :depends
    attr_accessor :dependencies
    attr_accessor :cmake
    attr_accessor :wayland
    attr_accessor :boost
    attr_accessor :version
    attr_accessor :summary
    attr_accessor :description
    attr_accessor :frameworks
    attr_accessor :external
    attr_accessor :apps
        
    def render
        ERB.new(File.read('Recipe.erb')).result(binding)
    end
end

appimage = Recipe.new
appimage.name = "peruse"
appimage.proper_name = appimage.name.capitalize
appimage.version = '16.04.1'
appimage.cmake = true
#TO_DO do some LD magic here? kdev-tools cmake parser?
appimage.depends = 'zlib-devel polkit-devel libattr-devel lmdb-devel libffi-devel expat-devel doxygen xmlto libXcursor-devel python-devel libxml2-devel bzip2-devel libxslt-devel xz-devel'
#Needed to add ability to pull in external builds that are simply to old
#in Centos.
appimage.external = 'libarchive,https://github.com/libarchive/libarchive,true,""'
appimage.wayland = true
appimage.boost = true
appimage.frameworks = 'karchive kconfig kwidgetsaddons kcompletion kcoreaddons kauth polkit-qt-1 kcodecs kdoctools ki18n kguiaddons kconfigwidgets kitemviews kiconthemes kjobwidgets kwindowsystem knotifications kcrash kdbusaddons kservice solid sonnet ktextwidgets attica kglobalaccel kxmlgui kbookmarks kio kpackage kfilemetadata kdeclarative kidletime kwayland kdecoration breeze plasma-integration'
appimage.apps = [Recipe::App.new("#{appimage.name}")]
File.write('Recipe', appimage.render)
