function [ddth1,ddth2,ddth3,ddphi1,ddphi2,ddphi3,ddx,ddy,ddz] = find_Dds_With_Double_Spring(dphi1,dphi2,dphi3,dth1,dth2,dth3,g,k,l_Arm,m1,m2,m3,phi1,phi2,phi3,tau1,tau2,tau3,th1,th2,th3,x,y,z)
%FIND_DDS_WITH_DOUBLE_SPRING
%    [DDTH1,DDTH2,DDTH3,DDPHI1,DDPHI2,DDPHI3,X_EQ,Y_EQ,Z_EQ] = FIND_DDS_WITH_DOUBLE_SPRING(DPHI1,DPHI2,DPHI3,DTH1,DTH2,DTH3,G,K,L_ARM,M1,M2,M3,PHI1,PHI2,PHI3,TAU1,TAU2,TAU3,TH1,TH2,TH3,X,Y,Z)

%    This function was generated by the Symbolic Math Toolbox version 8.6.
%    31-May-2021 18:00:52

t2 = cos(phi1);
t3 = cos(phi2);
t4 = cos(phi3);
t5 = cos(th1);
t6 = cos(th2);
t7 = cos(th3);
t8 = sin(phi1);
t9 = sin(phi2);
t10 = sin(phi3);
t11 = sin(th1);
t12 = sin(th2);
t13 = sin(th3);
t14 = g.*m1;
t15 = g.*m2;
t16 = g.*m3;
t17 = dphi1.^2;
t18 = dphi2.^2;
t19 = dphi3.^2;
t20 = dth1.^2;
t21 = dth2.^2;
t22 = dth3.^2;
t23 = l_Arm.^2;
t27 = k.*x.*2.0;
t31 = k.*y.*2.0;
t32 = k.*z.*2.0;
t24 = t2.^2;
t25 = t3.^2;
t26 = t4.^2;
t28 = t8.^2;
t29 = t9.^2;
t30 = t10.^2;
t33 = k.*l_Arm.*t5;
t34 = k.*l_Arm.*t6;
t35 = k.*l_Arm.*t7;
t36 = -t14;
t37 = -t15;
t38 = -t16;
t39 = -t27;
t40 = -t31;
t41 = -t32;
t42 = l_Arm.*t11.*t14;
t43 = l_Arm.*t11.*t15;
t44 = l_Arm.*t12.*t15;
t45 = l_Arm.*t11.*t16;
t46 = l_Arm.*t12.*t16;
t47 = l_Arm.*t13.*t16;
t48 = k.*l_Arm.*t11.*z;
t49 = k.*l_Arm.*t12.*z;
t50 = k.*l_Arm.*t13.*z;
t51 = k.*l_Arm.*t8.*t11;
t52 = k.*l_Arm.*t9.*t12;
t53 = k.*l_Arm.*t10.*t13;
t57 = k.*l_Arm.*t2.*t11;
t58 = k.*l_Arm.*t3.*t12;
t59 = k.*l_Arm.*t4.*t13;
t72 = l_Arm.*m1.*t5.*t20;
t73 = l_Arm.*m2.*t5.*t20;
t74 = l_Arm.*m3.*t5.*t20;
t75 = l_Arm.*m2.*t6.*t21;
t76 = l_Arm.*m3.*t6.*t21;
t77 = l_Arm.*m3.*t7.*t22;
t81 = k.*t5.*t11.*t23;
t82 = k.*t5.*t12.*t23;
t83 = k.*t6.*t11.*t23;
t84 = k.*t5.*t13.*t23;
t85 = k.*t6.*t12.*t23;
t86 = k.*t7.*t11.*t23;
t87 = k.*t6.*t13.*t23;
t88 = k.*t7.*t12.*t23;
t89 = k.*t7.*t13.*t23;
t102 = dphi1.*dth1.*l_Arm.*m1.*t2.*t5.*2.0;
t103 = dphi1.*dth1.*l_Arm.*m2.*t2.*t5.*2.0;
t104 = dphi1.*dth1.*l_Arm.*m3.*t2.*t5.*2.0;
t105 = dphi2.*dth2.*l_Arm.*m2.*t3.*t6.*2.0;
t106 = dphi2.*dth2.*l_Arm.*m3.*t3.*t6.*2.0;
t107 = dphi3.*dth3.*l_Arm.*m3.*t4.*t7.*2.0;
t108 = l_Arm.*m1.*t2.*t11.*t17;
t109 = l_Arm.*m2.*t2.*t11.*t17;
t110 = l_Arm.*m3.*t2.*t11.*t17;
t111 = l_Arm.*m2.*t3.*t12.*t18;
t112 = l_Arm.*m3.*t3.*t12.*t18;
t113 = l_Arm.*m3.*t4.*t13.*t19;
t114 = l_Arm.*m1.*t2.*t11.*t20;
t115 = l_Arm.*m2.*t2.*t11.*t20;
t116 = l_Arm.*m3.*t2.*t11.*t20;
t117 = l_Arm.*m2.*t3.*t12.*t21;
t118 = l_Arm.*m3.*t3.*t12.*t21;
t119 = l_Arm.*m3.*t4.*t13.*t22;
t120 = dphi1.*dth1.*l_Arm.*m1.*t5.*t8.*2.0;
t121 = dphi1.*dth1.*l_Arm.*m2.*t5.*t8.*2.0;
t122 = dphi1.*dth1.*l_Arm.*m3.*t5.*t8.*2.0;
t123 = dphi2.*dth2.*l_Arm.*m2.*t6.*t9.*2.0;
t124 = dphi2.*dth2.*l_Arm.*m3.*t6.*t9.*2.0;
t125 = dphi3.*dth3.*l_Arm.*m3.*t7.*t10.*2.0;
t126 = l_Arm.*m1.*t8.*t11.*t17;
t127 = l_Arm.*m2.*t8.*t11.*t17;
t128 = l_Arm.*m3.*t8.*t11.*t17;
t129 = l_Arm.*m2.*t9.*t12.*t18;
t130 = l_Arm.*m3.*t9.*t12.*t18;
t131 = l_Arm.*m3.*t10.*t13.*t19;
t132 = l_Arm.*m1.*t8.*t11.*t20;
t133 = l_Arm.*m2.*t8.*t11.*t20;
t134 = l_Arm.*m3.*t8.*t11.*t20;
t135 = l_Arm.*m2.*t9.*t12.*t21;
t136 = l_Arm.*m3.*t9.*t12.*t21;
t137 = l_Arm.*m3.*t10.*t13.*t22;
t144 = m1.*t5.*t11.*t20.*t23;
t145 = m2.*t5.*t11.*t20.*t23;
t146 = m2.*t5.*t12.*t20.*t23;
t147 = m3.*t5.*t11.*t20.*t23;
t148 = m3.*t5.*t12.*t20.*t23;
t149 = m2.*t6.*t11.*t21.*t23;
t150 = m3.*t5.*t13.*t20.*t23;
t151 = m2.*t6.*t12.*t21.*t23;
t152 = m3.*t6.*t11.*t21.*t23;
t153 = m3.*t6.*t12.*t21.*t23;
t154 = m3.*t6.*t13.*t21.*t23;
t155 = m3.*t7.*t11.*t22.*t23;
t156 = m3.*t7.*t12.*t22.*t23;
t157 = m3.*t7.*t13.*t22.*t23;
t158 = k.*t2.*t9.*t11.*t12.*t23;
t159 = k.*t3.*t8.*t11.*t12.*t23;
t162 = k.*t2.*t10.*t11.*t13.*t23;
t163 = k.*t4.*t8.*t11.*t13.*t23;
t166 = k.*t3.*t10.*t12.*t13.*t23;
t167 = k.*t4.*t9.*t12.*t13.*t23;
t256 = m2.*t2.*t3.*t6.*t11.*t17.*t23;
t257 = m3.*t2.*t3.*t6.*t11.*t17.*t23;
t258 = m2.*t2.*t3.*t5.*t12.*t18.*t23;
t259 = m3.*t2.*t3.*t5.*t12.*t18.*t23;
t260 = m3.*t2.*t4.*t7.*t11.*t17.*t23;
t261 = m3.*t2.*t4.*t5.*t13.*t19.*t23;
t262 = m3.*t3.*t4.*t7.*t12.*t18.*t23;
t263 = m3.*t3.*t4.*t6.*t13.*t19.*t23;
t264 = m2.*t2.*t3.*t6.*t11.*t20.*t23;
t265 = m3.*t2.*t3.*t6.*t11.*t20.*t23;
t266 = m2.*t2.*t3.*t5.*t12.*t21.*t23;
t267 = m3.*t2.*t3.*t5.*t12.*t21.*t23;
t268 = m3.*t2.*t4.*t7.*t11.*t20.*t23;
t269 = m3.*t2.*t4.*t5.*t13.*t22.*t23;
t270 = m3.*t3.*t4.*t7.*t12.*t21.*t23;
t271 = m3.*t3.*t4.*t6.*t13.*t22.*t23;
t272 = dphi1.*dth1.*m2.*t2.*t3.*t5.*t12.*t23.*2.0;
t273 = dphi1.*dth1.*m2.*t2.*t5.*t6.*t9.*t23.*2.0;
t274 = dphi1.*dth1.*m2.*t3.*t5.*t6.*t8.*t23.*2.0;
t275 = dphi1.*dth1.*m3.*t2.*t3.*t5.*t12.*t23.*2.0;
t276 = dphi1.*dth1.*m3.*t2.*t5.*t6.*t9.*t23.*2.0;
t277 = dphi1.*dth1.*m3.*t3.*t5.*t6.*t8.*t23.*2.0;
t278 = dphi2.*dth2.*m2.*t2.*t3.*t6.*t11.*t23.*2.0;
t279 = dphi2.*dth2.*m2.*t2.*t5.*t6.*t9.*t23.*2.0;
t280 = dphi2.*dth2.*m2.*t3.*t5.*t6.*t8.*t23.*2.0;
t281 = dphi1.*dth1.*m3.*t2.*t4.*t5.*t13.*t23.*2.0;
t282 = dphi1.*dth1.*m3.*t2.*t5.*t7.*t10.*t23.*2.0;
t283 = dphi1.*dth1.*m3.*t4.*t5.*t7.*t8.*t23.*2.0;
t284 = dphi2.*dth2.*m3.*t2.*t3.*t6.*t11.*t23.*2.0;
t285 = dphi2.*dth2.*m3.*t2.*t5.*t6.*t9.*t23.*2.0;
t286 = dphi2.*dth2.*m3.*t3.*t5.*t6.*t8.*t23.*2.0;
t287 = dphi2.*dth2.*m3.*t3.*t4.*t6.*t13.*t23.*2.0;
t288 = dphi2.*dth2.*m3.*t3.*t6.*t7.*t10.*t23.*2.0;
t289 = dphi2.*dth2.*m3.*t4.*t6.*t7.*t9.*t23.*2.0;
t290 = dphi3.*dth3.*m3.*t2.*t4.*t7.*t11.*t23.*2.0;
t291 = dphi3.*dth3.*m3.*t2.*t5.*t7.*t10.*t23.*2.0;
t292 = dphi3.*dth3.*m3.*t4.*t5.*t7.*t8.*t23.*2.0;
t293 = dphi3.*dth3.*m3.*t3.*t4.*t7.*t12.*t23.*2.0;
t294 = dphi3.*dth3.*m3.*t3.*t6.*t7.*t10.*t23.*2.0;
t295 = dphi3.*dth3.*m3.*t4.*t6.*t7.*t9.*t23.*2.0;
t296 = m2.*t2.*t9.*t11.*t12.*t17.*t23;
t297 = m2.*t3.*t8.*t11.*t12.*t17.*t23;
t298 = m2.*t6.*t8.*t9.*t11.*t17.*t23;
t299 = m3.*t2.*t9.*t11.*t12.*t17.*t23;
t300 = m3.*t3.*t8.*t11.*t12.*t17.*t23;
t301 = m3.*t6.*t8.*t9.*t11.*t17.*t23;
t302 = m2.*t2.*t9.*t11.*t12.*t18.*t23;
t303 = m2.*t3.*t8.*t11.*t12.*t18.*t23;
t304 = m2.*t5.*t8.*t9.*t12.*t18.*t23;
t305 = m3.*t2.*t9.*t11.*t12.*t18.*t23;
t306 = m3.*t3.*t8.*t11.*t12.*t18.*t23;
t307 = m3.*t5.*t8.*t9.*t12.*t18.*t23;
t308 = m3.*t2.*t10.*t11.*t13.*t17.*t23;
t309 = m3.*t4.*t8.*t11.*t13.*t17.*t23;
t310 = m3.*t7.*t8.*t10.*t11.*t17.*t23;
t311 = m3.*t2.*t10.*t11.*t13.*t19.*t23;
t312 = m3.*t4.*t8.*t11.*t13.*t19.*t23;
t313 = m3.*t5.*t8.*t10.*t13.*t19.*t23;
t314 = m3.*t3.*t10.*t12.*t13.*t18.*t23;
t315 = m3.*t4.*t9.*t12.*t13.*t18.*t23;
t316 = m3.*t7.*t9.*t10.*t12.*t18.*t23;
t317 = m3.*t3.*t10.*t12.*t13.*t19.*t23;
t318 = m3.*t4.*t9.*t12.*t13.*t19.*t23;
t319 = m3.*t6.*t9.*t10.*t13.*t19.*t23;
t320 = m2.*t2.*t9.*t11.*t12.*t20.*t23;
t321 = m2.*t3.*t8.*t11.*t12.*t20.*t23;
t322 = m2.*t6.*t8.*t9.*t11.*t20.*t23;
t323 = m3.*t2.*t9.*t11.*t12.*t20.*t23;
t324 = m3.*t3.*t8.*t11.*t12.*t20.*t23;
t325 = m3.*t6.*t8.*t9.*t11.*t20.*t23;
t326 = m2.*t2.*t9.*t11.*t12.*t21.*t23;
t327 = m2.*t3.*t8.*t11.*t12.*t21.*t23;
t328 = m2.*t5.*t8.*t9.*t12.*t21.*t23;
t329 = m3.*t2.*t9.*t11.*t12.*t21.*t23;
t330 = m3.*t3.*t8.*t11.*t12.*t21.*t23;
t331 = m3.*t5.*t8.*t9.*t12.*t21.*t23;
t332 = m3.*t2.*t10.*t11.*t13.*t20.*t23;
t333 = m3.*t4.*t8.*t11.*t13.*t20.*t23;
t334 = m3.*t7.*t8.*t10.*t11.*t20.*t23;
t335 = m3.*t2.*t10.*t11.*t13.*t22.*t23;
t336 = m3.*t4.*t8.*t11.*t13.*t22.*t23;
t337 = m3.*t5.*t8.*t10.*t13.*t22.*t23;
t338 = m3.*t3.*t10.*t12.*t13.*t21.*t23;
t339 = m3.*t4.*t9.*t12.*t13.*t21.*t23;
t340 = m3.*t7.*t9.*t10.*t12.*t21.*t23;
t341 = m3.*t3.*t10.*t12.*t13.*t22.*t23;
t342 = m3.*t4.*t9.*t12.*t13.*t22.*t23;
t343 = m3.*t6.*t9.*t10.*t13.*t22.*t23;
t344 = dphi1.*dth1.*m2.*t5.*t8.*t9.*t12.*t23.*2.0;
t345 = dphi1.*dth1.*m3.*t5.*t8.*t9.*t12.*t23.*2.0;
t346 = dphi2.*dth2.*m2.*t6.*t8.*t9.*t11.*t23.*2.0;
t347 = dphi1.*dth1.*m3.*t5.*t8.*t10.*t13.*t23.*2.0;
t348 = dphi2.*dth2.*m3.*t6.*t8.*t9.*t11.*t23.*2.0;
t349 = dphi2.*dth2.*m3.*t6.*t9.*t10.*t13.*t23.*2.0;
t350 = dphi3.*dth3.*m3.*t7.*t8.*t10.*t11.*t23.*2.0;
t351 = dphi3.*dth3.*m3.*t7.*t9.*t10.*t12.*t23.*2.0;
t54 = -t33;
t55 = -t34;
t56 = -t35;
t60 = t2.*t33.*x;
t61 = t3.*t34.*x;
t62 = t4.*t35.*x;
t63 = t57.*y;
t64 = t8.*t33.*y;
t65 = t58.*y;
t66 = t9.*t34.*y;
t67 = t59.*y;
t68 = t10.*t35.*y;
t69 = t51.*x;
t70 = t52.*x;
t71 = t53.*x;
t78 = -t51;
t79 = -t52;
t80 = -t53;
t90 = -t57;
t91 = -t58;
t92 = -t59;
t138 = -t102;
t139 = -t103;
t140 = -t104;
t141 = -t105;
t142 = -t106;
t143 = -t107;
t160 = t8.*t9.*t82;
t161 = t8.*t9.*t83;
t164 = t8.*t10.*t84;
t165 = t8.*t10.*t86;
t168 = t9.*t10.*t87;
t169 = t9.*t10.*t88;
t170 = t24.*t81;
t171 = t25.*t85;
t172 = t26.*t89;
t173 = t28.*t81;
t174 = t29.*t85;
t175 = t30.*t89;
t176 = t2.*t3.*t82;
t177 = t2.*t3.*t83;
t178 = t2.*t4.*t84;
t179 = t2.*t4.*t86;
t180 = t3.*t4.*t87;
t181 = t3.*t4.*t88;
t182 = -t144;
t183 = -t145;
t184 = -t146;
t185 = -t147;
t186 = -t148;
t187 = -t149;
t188 = -t150;
t189 = -t151;
t190 = -t152;
t191 = -t153;
t192 = -t154;
t193 = -t155;
t194 = -t156;
t195 = -t157;
t196 = -t158;
t197 = -t159;
t200 = -t162;
t201 = -t163;
t204 = -t166;
t205 = -t167;
t220 = m1.*t5.*t11.*t17.*t23.*t24;
t221 = m2.*t5.*t11.*t17.*t23.*t24;
t222 = m3.*t5.*t11.*t17.*t23.*t24;
t223 = m2.*t6.*t12.*t18.*t23.*t25;
t224 = m3.*t6.*t12.*t18.*t23.*t25;
t225 = m3.*t7.*t13.*t19.*t23.*t26;
t226 = t24.*t144;
t227 = t24.*t145;
t228 = t24.*t147;
t229 = t25.*t151;
t230 = t25.*t153;
t231 = t26.*t157;
t232 = dphi1.*dth1.*m1.*t5.*t11.*t23.*t24.*2.0;
t233 = dphi1.*dth1.*m2.*t5.*t11.*t23.*t24.*2.0;
t234 = dphi1.*dth1.*m3.*t5.*t11.*t23.*t24.*2.0;
t235 = dphi2.*dth2.*m2.*t6.*t12.*t23.*t25.*2.0;
t236 = dphi2.*dth2.*m3.*t6.*t12.*t23.*t25.*2.0;
t237 = dphi3.*dth3.*m3.*t7.*t13.*t23.*t26.*2.0;
t238 = m1.*t5.*t11.*t17.*t23.*t28;
t239 = m2.*t5.*t11.*t17.*t23.*t28;
t240 = m3.*t5.*t11.*t17.*t23.*t28;
t241 = m2.*t6.*t12.*t18.*t23.*t29;
t242 = m3.*t6.*t12.*t18.*t23.*t29;
t243 = m3.*t7.*t13.*t19.*t23.*t30;
t244 = t28.*t144;
t245 = t28.*t145;
t246 = t28.*t147;
t247 = t29.*t151;
t248 = t29.*t153;
t249 = t30.*t157;
t250 = dphi1.*dth1.*m1.*t5.*t11.*t23.*t28.*2.0;
t251 = dphi1.*dth1.*m2.*t5.*t11.*t23.*t28.*2.0;
t252 = dphi1.*dth1.*m3.*t5.*t11.*t23.*t28.*2.0;
t253 = dphi2.*dth2.*m2.*t6.*t12.*t23.*t29.*2.0;
t254 = dphi2.*dth2.*m3.*t6.*t12.*t23.*t29.*2.0;
t255 = dphi3.*dth3.*m3.*t7.*t13.*t23.*t30.*2.0;
t352 = -t273;
t353 = -t276;
t354 = -t280;
t355 = -t282;
t356 = -t286;
t357 = -t288;
t358 = -t292;
t359 = -t295;
t360 = -t297;
t361 = -t300;
t362 = -t302;
t363 = -t305;
t364 = -t309;
t365 = -t311;
t366 = -t315;
t367 = -t317;
t368 = -t321;
t369 = -t324;
t370 = -t326;
t371 = -t329;
t372 = -t333;
t373 = -t335;
t374 = -t339;
t375 = -t341;
t93 = t2.*t54.*x;
t94 = t3.*t55.*x;
t95 = t4.*t56.*x;
t96 = t8.*t54.*y;
t97 = t9.*t55.*y;
t98 = t10.*t56.*y;
t99 = -t69;
t100 = -t70;
t101 = -t71;
t198 = -t160;
t199 = -t161;
t202 = -t164;
t203 = -t165;
t206 = -t168;
t207 = -t169;
t208 = -t170;
t209 = -t171;
t210 = -t172;
t211 = -t173;
t212 = -t174;
t213 = -t175;
t214 = -t176;
t215 = -t177;
t216 = -t178;
t217 = -t179;
t218 = -t180;
t219 = -t181;
t376 = t36+t37+t38+t41+t54+t55+t56+t72+t73+t74+t75+t76+t77;
t377 = t39+t90+t91+t92+t108+t109+t110+t111+t112+t113+t114+t115+t116+t117+t118+t119+t120+t121+t122+t123+t124+t125;
t378 = t40+t78+t79+t80+t126+t127+t128+t129+t130+t131+t132+t133+t134+t135+t136+t137+t138+t139+t140+t141+t142+t143;
t379 = t67+t101+t163+t167+t200+t204+t237+t255+t281+t287+t308+t314+t332+t338+t347+t349+t364+t366+t372+t374;
t382 = t65+t100+t159+t166+t196+t205+t235+t236+t253+t254+t272+t275+t293+t296+t299+t318+t320+t323+t342+t344+t345+t351+t360+t361+t367+t368+t369+t375;
t385 = t47+t50+t84+t87+t89+t95+t98+t188+t192+t195+t203+t207+t210+t213+t217+t219+t225+t231+t243+t249+t260+t262+t268+t270+t283+t289+t310+t316+t334+t340+t355+t357+tau3;
t386 = t63+t99+t158+t162+t197+t201+t232+t233+t234+t250+t251+t252+t278+t284+t290+t303+t306+t312+t327+t330+t336+t346+t348+t350+t362+t363+t365+t370+t371+t373;
t389 = t44+t46+t49+t82+t85+t88+t94+t97+t184+t186+t189+t191+t194+t199+t206+t209+t212+t215+t218+t223+t224+t229+t230+t241+t242+t247+t248+t256+t257+t263+t264+t265+t271+t274+t277+t294+t298+t301+t319+t322+t325+t343+t352+t353+t359+tau2;
t390 = t42+t43+t45+t48+t81+t83+t86+t93+t96+t182+t183+t185+t187+t190+t193+t198+t202+t208+t211+t214+t216+t220+t221+t222+t226+t227+t228+t238+t239+t240+t244+t245+t246+t258+t259+t261+t266+t267+t269+t279+t285+t291+t304+t307+t313+t328+t331+t337+t354+t356+t358+tau1;
t380 = sign(t379);
t383 = sign(t382);
t387 = sign(t386);
t381 = -t380;
t384 = -t383;
t388 = -t387;
t391 = t377.*Inf+t378.*Inf+t381.*Inf+t384.*Inf+t385.*Inf+t388.*Inf+t389.*Inf+t390.*Inf+(-sign(t14+t15+t16+t32+t33+t34+t35-t72-t73-t74-t75-t76-t77)).*Inf;
ddth1 = t391;
if nargout > 1
    ddth2 = t391;
end
if nargout > 2
    ddth3 = t391;
end
if nargout > 3
    ddphi1 = t391;
end
if nargout > 4
    ddphi2 = t391;
end
if nargout > 5
    ddphi3 = t391;
end
if nargout > 6
    ddx = t391;
end
if nargout > 7
    ddy = t391;
end
if nargout > 8
    ddz = t391;
end
