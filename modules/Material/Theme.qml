/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014 Michael Spencer
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, either version 2.1 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.0

pragma Singleton

/*!
   \qmltype Theme
   \inqmlmodule Material 0.1
   \ingroup material

   \brief Provides access to standard colors that follow the Material Design specification.

   See \l {http://www.google.com/design/spec/style/color.html#color-ui-color-application} for
   details about choosing a color scheme for your application.
 */
Object {
    id: theme

    /*!
       The primary color used for the toolbar background unless a page specifies its own color.
       This can be customized via the \l ApplicationWindow::theme group property. According to the
       Material Design guidelines, this should normally be a 500 color from one of the color
       palettes at \l {http://www.google.com/design/spec/style/color.html#color-color-palette}.
     */
    property color primaryColor: "#5677fc"

    /*!
       A darker version of the primary color used for the window titlebar (if client-side
       decorations are not used), unless a \l Page specifies its own primary and primary dark
       colors. This can be customized via the \l ApplicationWindow::theme group property. According
       to the Material Design guidelines, this should normally be the 700 color version of your
       aplication's primary color, taken from one of the color palettes at
       \l {http://www.google.com/design/spec/style/color.html#color-color-palette}.
    */
    property color primaryDarkColor: "#5677fc"

    /*!
       The accent color complements the primary color, and is used for any primary action buttons
       along with switches, sliders, and other components that do not specifically set a color.
       This can be customized via the  \l ApplicationWindow::theme group property. According
       to the Material Design guidelines, this should taken from a second color palette that
       complements the primary color palette at
       \l {http://www.google.com/design/spec/style/color.html#color-color-palette}.
    */
    property color accentColor: "white"

    /*!
       The default background color for the application.
     */
    property color backgroundColor: "#f3f3f3"

    /*!
       Standard colors specifically meant for light surfaces. This includes text colors along with
       a light version of the accent color.
     */
    property ThemePalette light: ThemePalette {
        light: true
    }

    /*!
       Standard colors specifically meant for dark surfaces. This includes text colors along with
       a dark version of the accent color.
    */
    property ThemePalette dark: ThemePalette {
        light: false
    }

    /*!
       Select a color depending on whether the background is light or dark.

       \c lightColor is the color used on a light background.

       \c darkColor is the color used on a dark background.
     */
    function lightDark(background, lightColor, darkColor) {
        var temp = Qt.darker(background, 1)

        var a = 1 - ( 0.299 * temp.r + 0.587 * temp.g + 0.114 * temp.b);

        if (a < 0.3)
            return lightColor
        else
            return darkColor
    }

   // Dynamic loading of fonts
   function getFont(style) {
   	if (typeof(eval(style)) != "undefined") {
		return eval(style).name; 
	}
	else {
		var fontStyles = ["Black", "BlackItalic", "Bold", "BoldItalic", "Italic", "Light", "LightItalic", "Medium", "MediumItalic", "Regular", "Thin", "ThinItalic", "CondensedBold", "CondensedBoldItalic", "CondensedItalic", "CondensedLight", "CondensedLightItalic", "CondensedRegular", "awesome"];
	   	if (fontStyles.indexOf(style) == -1) {
			throw "Wrong style."
	   	}
	   	var source;
	   	if (style == "awesome") {
			source = "fonts/fontawesome/FontAwesome.otf";
	   	}
	   	else if (style[0] == "C") {
			source = "fonts/roboto/RobotoCondensed-" + style.slice(9) + ".ttf";
	   	}
	   	else {
			source = "fonts/roboto/Roboto-" + style + ".ttf";
	   	}
	   	var initiatorString = "import QtQuick 2.0; FontLoader { id: " + style + "; source: \"" + source + "\"}";
	   	var font = Qt.createQmlObject(initiatorString, theme, "dynamicFont");
	   	return font.name;
   	}
   }
    /*FontLoader {
        source: Qt.resolvedUrl("fonts/roboto/Roboto-Regular.ttf")
        id: robotoFont
    }*/
}
