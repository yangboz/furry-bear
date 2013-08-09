<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<document type="com.apple.InterfaceBuilder3.CocoaTouch.Storyboard.XIB" version="2.0" toolsVersion="3084" systemVersion="12E3067" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" initialViewController="4">
    <dependencies>
        <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="2083"/>
    </dependencies>
    <scenes>
        <!--First View Controller - First-->
        <scene sceneID="11">
            <objects>
                <viewController title="First" id="2" customClass="FirstViewController" sceneMemberID="viewController">
                    <view key="view" contentMode="scaleToFill" id="16">
                        <rect key="frame" x="0.0" y="20" width="320" height="499"/>
                        <autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/>
                        <subviews>
                            <label opaque="NO" clipsSubviews="YES" userInteractionEnabled="NO" contentMode="scaleToFill" text="First View" textAlignment="center" lineBreakMode="tailTruncation" minimumFontSize="10" translatesAutoresizingMaskIntoConstraints="NO" id="20">
                                <color key="backgroundColor" white="1" alpha="1" colorSpace="custom" customColorSpace="calibratedWhite"/>
                                <fontDescription key="fontDescription" name="Helvetica" family="Helvetica" pointSize="36"/>
                                <color key="textColor" cocoaTouchSystemColor="darkTextColor"/>
                                <nil key="highlightedColor"/>
                            </label>
                            <textView opaque="NO" clipsSubviews="YES" multipleTouchEnabled="YES" userInteractionEnabled="NO" contentMode="scaleToFill" showsHorizontalScrollIndicator="NO" delaysContentTouches="NO" canCancelContentTouches="NO" minimumZoomScale="0.0" maximumZoomScale="0.0" bouncesZoom="NO" editable="NO" text="Loaded by the first view controller — an instance of FirstViewController — specified in the app delegate." textAlignment="center" translatesAutoresizingMaskIntoConstraints="NO" id="21">
                                <constraints>
                                    <constraint firstAttribute="height" constant="88" id="Ikv-jk-tyi"/>
                                </constraints>
                                <fontDescription key="fontDescription" type="system" size="system"/>
                                <textInputTraits key="textInputTraits"/>
                            </textView>
                        </subviews>
                        <color key="backgroundColor" white="1" alpha="1" colorSpace="custom" customColorSpace="calibratedWhite"/>
                        <constraints>
                            <constraint firstAttribute="trailing" secondItem="21" secondAttribute="trailing" constant="20" symbolic="YES" type="default" id="QBg-X6-fBV"/>
                            <constraint firstAttribute="trailing" secondItem="20" secondAttribute="trailing" constant="20" symbolic="YES" type="default" id="Qxj-1L-2Yh"/>
                            <constraint firstItem="20" firstAttribute="leading" secondItem="16" secondAttribute="leading" constant="20" symbolic="YES" type="default" id="Ty9-wx-CyI"/>
                            <constraint firstItem="21" firstAttribute="leading" secondItem="16" secondAttribute="leading" constant="20" symbolic="YES" type="default" id="Zmm-k2-2L7"/>
                            <constraint firstItem="21" firstAttribute="top" secondItem="20" secondAttribute="bottom" constant="40" type="user" id="jX0-Wi-kmb"/>
                            <constraint firstAttribute="centerY" secondItem="21" secondAttribute="centerY" type="user" id="yWk-L2-m9F"/>
                        </constraints>
                    </view>
                    <tabBarItem key="tabBarItem" systemItem="featured" id="7"/>
                </viewController>
                <placeholder placeholderIdentifier="IBFirstResponder" id="10" sceneMemberID="firstResponder"/>
            </objects>
            <point key="canvasLocation" x="653" y="-138"/>
        </scene>
        <!--Second View Controller - Second-->
        <scene sceneID="13">
            <objects>
                <viewController title="Second" id="3" customClass="SecondViewController" sceneMemberID="viewController">
                    <view key="view" contentMode="scaleToFill" id="17">
                        <rect key="frame" x="0.0" y="20" width="320" height="499"/>
                        <autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/>
                        <subviews>
                            <label opaque="NO" clipsSubviews="YES" userInteractionEnabled="NO" contentMode="scaleToFill" text="Second View" textAlignment="center" lineBreakMode="tailTruncation" minimumFontSize="10" translatesAutoresizingMaskIntoConstraints="NO" id="22">
                                <color key="backgroundColor" white="1" alpha="1" colorSpace="custom" customColorSpace="calibratedWhite"/>
                                <fontDescription key="fontDescription" name="Helvetica" family="Helvetica" pointSize="36"/>
                                <color key="textColor" cocoaTouchSystemColor="darkTextColor"/>
                                <nil key="highlightedColor"/>
                            </label>
                            <textView opaque="NO" clipsSubviews="YES" multipleTouchEnabled="YES" userInteractionEnabled="NO" contentMode="scaleToFill" showsHorizontalScrollIndicator="NO" delaysContentTouches="NO" canCancelContentTouches="NO" minimumZoomScale="0.0" maximumZoomScale="0.0" bouncesZoom="NO" editable="NO" text="Loaded by the second view controller — an instance of SecondViewController — specified in the app delegate." textAlignment="center" translatesAutoresizingMaskIntoConstraints="NO" id="23">
                                <constraints>
                                    <constraint firstAttribute="height" constant="88" id="cQR-IW-sY8"/>
                                </constraints>
                                <fontDescription key="fontDescription" type="system" size="system"/>
                                <textInputTraits key="textInputTraits"/>
                            </textView>
                        </subviews>
                        <color key="backgroundColor" white="1" alpha="1" colorSpace="custom" customColorSpace="calibratedWhite"/>
                        <constraints>
                            <constraint firstItem="22" firstAttribute="leading" secondItem="17" secondAttribute="leading" constant="20" symbolic="YES" type="default" id="0q6-IA-e8m"/>
                            <constraint firstAttribute="trailing" secondItem="23" secondAttribute="trailing" constant="20" symbolic="YES" type="default" id="fR4-wH-Ih7"/>
                            <constraint firstItem="23" firstAttribute="leading" secondItem="17" secondAttribute="leading" constant="20" symbolic="YES" type="default" id="fzb-YA-SeR"/>
                            <constraint firstAttribute="centerY" secondItem="23" secondAttribute="centerY" type="user" id="llH-eD-iPS"/>
                            <constraint firstAttribute="trailing" secondItem="22" secondAttribute="trailing" constant="20" symbolic="YES" type="default" id="pc3-9Y-W42"/>
                            <constraint firstItem="23" firstAttribute="top" secondItem="22" secondAttribute="bottom" constant="40" type="user" id="yUx-Ee-KEk"/>
                        </constraints>
                    </view>
                    <tabBarItem key="tabBarItem" systemItem="favorites" id="6"/>
                </viewController>
                <placeholder placeholderIdentifier="IBFirstResponder" id="12" sceneMemberID="firstResponder"/>
            </objects>
            <point key="canvasLocation" x="653" y="498"/>
        </scene>
        <!--Tab Bar Controller-->
        <scene sceneID="15">
            <objects>
                <tabBarController id="4" sceneMemberID="viewController">
                    <nil key="simulatedBottomBarMetrics"/>
                    <tabBar key="tabBar" contentMode="scaleToFill" id="5">
                        <rect key="frame" x="0.0" y="431" width="320" height="49"/>
                        <autoresizingMask key="autoresizingMask" widthSizable="YES" flexibleMinY="YES"/>
                        <color key="backgroundColor" white="0.0" alpha="0.0" colorSpace="calibratedWhite"/>
                    </tabBar>
                    <connections>
                        <segue destination="2" kind="relationship" relationship="viewControllers" id="26"/>
                        <segue destination="3" kind="relationship" relationship="viewControllers" id="27"/>
                    </connections>
                </tabBarController>
                <placeholder placeholderIdentifier="IBFirstResponder" id="14" sceneMemberID="firstResponder"/>
            </objects>
            <point key="canvasLocation" x="132" y="180"/>
        </scene>
    </scenes>
    <classes>
        <class className="FirstViewController" superclassName="UIViewController">
            <source key="sourceIdentifier" type="project" relativePath="./Classes/FirstViewController.h"/>
        </class>
        <class className="NSLayoutConstraint" superclassName="NSObject">
            <source key="sourceIdentifier" type="project" relativePath="./Classes/NSLayoutConstraint.h"/>
        </class>
        <class className="SecondViewController" superclassName="UIViewController">
            <source key="sourceIdentifier" type="project" relativePath="./Classes/SecondViewController.h"/>
        </class>
    </classes>
    <simulatedMetricsContainer key="defaultSimulatedMetrics">
        <simulatedStatusBarMetrics key="statusBar"/>
        <simulatedOrientationMetrics key="orientation"/>
        <simulatedScreenMetrics key="destination" type="retina4"/>
    </simulatedMetricsContainer>
</document>