.class public final Lcom/xiaoji/egggame/MainActivity;
.super Lcom/xiaoji/egggame/core/android/base/GamepadInputHostActivity;
.source "r8-map-id-60560d24e8bcc45c0b2a1383d0d901f6ddb757a48af5ae5971565c863742b7e9"


# static fields
.field public static final g:I


# instance fields
.field public final e:Ljava/lang/String;

.field public final f:Lkotlin/Lazy;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    .line 2
    .line 3
    .line 4
    invoke-static {}, Landroid/os/Process;->myPid()I

    .line 5
    .line 6
    .line 7
    move-result v0

    .line 8
    sput v0, Lcom/xiaoji/egggame/MainActivity;->g:I

    .line 9
    .line 10
    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 1
    invoke-direct {p0}, Lcom/xiaoji/egggame/core/android/base/GamepadInputHostActivity;-><init>()V

    .line 2
    .line 3
    .line 4
    invoke-static {p0}, Ljava/lang/System;->identityHashCode(Ljava/lang/Object;)I

    .line 5
    .line 6
    .line 7
    move-result v0

    .line 8
    const/16 v1, 0x10

    .line 9
    .line 10
    invoke-static {v1}, Luj1;->G(I)V

    .line 11
    .line 12
    .line 13
    invoke-static {v0, v1}, Ljava/lang/Integer;->toString(II)Ljava/lang/String;

    .line 14
    .line 15
    .line 16
    move-result-object v0

    .line 17
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 18
    .line 19
    .line 20
    const-string v1, "MainActivity@"

    .line 21
    .line 22
    invoke-virtual {v1, v0}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    .line 23
    .line 24
    .line 25
    move-result-object v0

    .line 26
    iput-object v0, p0, Lcom/xiaoji/egggame/MainActivity;->e:Ljava/lang/String;

    .line 27
    .line 28
    new-instance v0, Lei0;

    .line 29
    .line 30
    const/16 v1, 0x9

    .line 31
    .line 32
    invoke-direct {v0, p0, v1}, Lei0;-><init>(Ljava/lang/Object;I)V

    .line 33
    .line 34
    .line 35
    sget-object v1, Ls1c;->a:Ls1c;

    .line 36
    .line 37
    invoke-static {v1, v0}, Lbh6;->Q(Ls1c;Lwq6;)Lkotlin/Lazy;

    .line 38
    .line 39
    .line 40
    move-result-object v0

    .line 41
    iput-object v0, p0, Lcom/xiaoji/egggame/MainActivity;->f:Lkotlin/Lazy;

    .line 42
    .line 43
    return-void
.end method


# virtual methods
.method public final f(Landroid/content/Intent;)V
    .locals 5

    .line 1
    const-string v0, "app_nav_target"

    .line 2
    .line 3
    const/4 v1, 0x0

    .line 4
    if-eqz p1, :cond_0

    .line 5
    .line 6
    invoke-virtual {p1, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    .line 7
    .line 8
    .line 9
    move-result-object v2

    .line 10
    goto :goto_0

    .line 11
    :cond_0
    move-object v2, v1

    .line 12
    :goto_0
    const-string v3, ""

    .line 13
    .line 14
    if-nez v2, :cond_1

    .line 15
    .line 16
    move-object v2, v3

    .line 17
    :cond_1
    const-string v4, "local_game_launch"

    .line 18
    .line 19
    invoke-virtual {v2, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    .line 20
    .line 21
    .line 22
    move-result v2

    .line 23
    if-nez v2, :cond_2

    .line 24
    .line 25
    goto :goto_3

    .line 26
    :cond_2
    if-eqz p1, :cond_3

    .line 27
    .line 28
    const-string v2, "app_nav_game_id"

    .line 29
    .line 30
    invoke-virtual {p1, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    .line 31
    .line 32
    .line 33
    move-result-object v2

    .line 34
    goto :goto_1

    .line 35
    :cond_3
    move-object v2, v1

    .line 36
    :goto_1
    if-nez v2, :cond_4

    .line 37
    .line 38
    goto :goto_2

    .line 39
    :cond_4
    move-object v3, v2

    .line 40
    :goto_2
    invoke-static {v3}, Lm1l;->P0(Ljava/lang/CharSequence;)Z

    .line 41
    .line 42
    .line 43
    move-result v2

    .line 44
    if-eqz v2, :cond_5

    .line 45
    .line 46
    goto :goto_3

    .line 47
    :cond_5
    invoke-interface {p0}, Lttc;->getLifecycle()Landroidx/lifecycle/Lifecycle;

    .line 48
    .line 49
    .line 50
    move-result-object v2

    .line 51
    invoke-static {v2}, Landroidx/lifecycle/m;->a(Landroidx/lifecycle/Lifecycle;)Landroidx/lifecycle/k;

    .line 52
    .line 53
    .line 54
    move-result-object v2

    .line 55
    new-instance v4, Lnhd;

    .line 56
    .line 57
    invoke-direct {v4, p0, v3, v1}, Lnhd;-><init>(Lcom/xiaoji/egggame/MainActivity;Ljava/lang/String;Lee3;)V

    .line 58
    .line 59
    .line 60
    const/4 p0, 0x3

    .line 61
    invoke-static {v2, v1, v4, p0}, Lnt3;->s0(Lii3;Lzh3;Lmr6;I)Lm1k;

    .line 62
    .line 63
    .line 64
    if-eqz p1, :cond_6

    .line 65
    .line 66
    invoke-virtual {p1, v0}, Landroid/content/Intent;->removeExtra(Ljava/lang/String;)V

    .line 67
    .line 68
    .line 69
    :cond_6
    :goto_3
    return-void
.end method

.method public final onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 0

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 2
    .line 3
    .line 4
    invoke-super {p0, p1}, Landroidx/activity/ComponentActivity;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    .line 5
    .line 6
    .line 7
    sget-object p0, Lm5j;->c:Lh3d;

    .line 8
    .line 9
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 10
    .line 11
    .line 12
    iget-boolean p0, p0, Lh3d;->b:Z

    .line 13
    .line 14
    if-eqz p0, :cond_0

    .line 15
    .line 16
    goto :goto_0

    .line 17
    :cond_0
    sget-object p0, Lg8o;->y:Lnh;

    .line 18
    .line 19
    if-eqz p0, :cond_1

    .line 20
    .line 21
    :goto_0
    return-void

    .line 22
    :cond_1
    const-string p0, "info"

    .line 23
    .line 24
    invoke-static {p0}, Lmha;->h0(Ljava/lang/String;)V

    .line 25
    .line 26
    .line 27
    const/4 p0, 0x0

    .line 28
    throw p0
.end method

.method public final onCreate(Landroid/os/Bundle;)V
.locals 8

    .line 1
    const/4 v0, 0x0


    # BannerHub Proof-of-Concept: Show Toast
        # BannerHub: Add tabs via helper class
    invoke-static {p0}, Lcom/xiaoji/eggame/BannerHubHelper;->addTabsToActivity(Landroid/app/Activity;)V

    move-result-object v7
    invoke-virtual {v7}, Landroid/widget/Toast;->show()V

    .line 2
    invoke-static {v0}, Lze6;->s(Ljava/lang/String;)Lwmj;

    .line 3
    .line 4
    .line 5
    move-result-object v1

    .line 6
    sget-object v2, Lpri;->a:Lqhn;

    .line 7
    .line 8
    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 9
    .line 10
    .line 11
    sget-object v2, Lpri;->b:Lpri;

    .line 12
    .line 13
    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 14
    .line 15
    .line 16
    const-string v3, "screen_orientation_mode"

    .line 17
    .line 18
    invoke-virtual {v1, v3}, Lwmj;->a(Ljava/lang/String;)Ljava/lang/String;

    .line 19
    .line 20
    .line 21
    move-result-object v1

    .line 22
    if-nez v1, :cond_0

    .line 23
    .line 24
    move-object v1, v0

    .line 25
    :cond_0
    sget-object v3, Lpri;->g:Loa5;

    .line 26
    .line 27
    invoke-interface {v3}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    .line 28
    .line 29
    .line 30
    move-result-object v3

    .line 31
    :cond_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    .line 32
    .line 33
    .line 34
    move-result v4

    .line 35
    if-eqz v4, :cond_2

    .line 36
    .line 37
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 38
    .line 39
    .line 40
    move-result-object v4

    .line 41
    move-object v5, v4

    .line 42
    check-cast v5, Lpri;

    .line 43
    .line 44
    invoke-virtual {v5}, Lpri;->a()Ljava/lang/String;

    .line 45
    .line 46
    .line 47
    move-result-object v5

    .line 48
    invoke-static {v5, v1}, Lt1l;->l0(Ljava/lang/String;Ljava/lang/String;)Z

    .line 49
    .line 50
    .line 51
    move-result v5

    .line 52
    if-eqz v5, :cond_1

    .line 53
    .line 54
    goto :goto_0

    .line 55
    :cond_2
    move-object v4, v0

    .line 56
    :goto_0
    check-cast v4, Lpri;

    .line 57
    .line 58
    if-nez v4, :cond_3

    .line 59
    .line 60
    goto :goto_1

    .line 61
    :cond_3
    move-object v2, v4

    .line 62
    :goto_1
    invoke-virtual {v2}, Ljava/lang/Enum;->ordinal()I

    .line 63
    .line 64
    .line 65
    move-result v1

    .line 66
    const/4 v2, 0x2

    .line 67
    const/4 v3, 0x1

    .line 68
    if-eqz v1, :cond_6

    .line 69
    .line 70
    if-eq v1, v3, :cond_5

    .line 71
    .line 72
    if-ne v1, v2, :cond_4

    .line 73
    .line 74
    const/4 v1, 0x6

    .line 75
    goto :goto_2

    .line 76
    :cond_4
    invoke-static {}, Lsx3;->n()V

    .line 77
    .line 78
    .line 79
    return-void

    .line 80
    :cond_5
    const/4 v1, 0x7

    .line 81
    goto :goto_2

    .line 82
    :cond_6
    const/4 v1, -0x1

    .line 83
    :goto_2
    sget-object v4, Lm5j;->c:Lh3d;

    .line 84
    .line 85
    invoke-virtual {v4}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 86
    .line 87
    .line 88
    iget-boolean v4, v4, Lh3d;->b:Z

    .line 89
    .line 90
    const-string v5, "info"

    .line 91
    .line 92
    if-eqz v4, :cond_7

    .line 93
    .line 94
    goto :goto_3

    .line 95
    :cond_7
    sget-object v6, Lg8o;->y:Lnh;

    .line 96
    .line 97
    if-eqz v6, :cond_12

    .line 98
    .line 99
    :goto_3
    invoke-virtual {p0, v1}, Landroid/app/Activity;->setRequestedOrientation(I)V

    .line 100
    .line 101
    .line 102
    invoke-static {p0}, Lqz4;->a(Landroidx/activity/ComponentActivity;)V

    .line 103
    .line 104
    .line 105
    invoke-super {p0, p1}, Lcom/xiaoji/egggame/core/android/base/BaseActivity;->onCreate(Landroid/os/Bundle;)V

    .line 106
    .line 107
    .line 108
    invoke-static {p0}, Lbao;->E(Landroidx/activity/ComponentActivity;)V

    .line 109
    .line 110
    .line 111
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    .line 112
    .line 113
    .line 114
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    .line 115
    .line 116
    .line 117
    move-result-object p1

    .line 118
    invoke-virtual {p1}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    .line 119
    .line 120
    .line 121
    move-result-object p1

    .line 122
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 123
    .line 124
    .line 125
    invoke-static {p1}, Lpl6;->o(Landroid/content/res/Configuration;)Ljava/lang/String;

    .line 126
    .line 127
    .line 128
    invoke-virtual {p0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    .line 129
    .line 130
    .line 131
    move-result-object p1

    .line 132
    if-nez p1, :cond_8

    .line 133
    .line 134
    goto :goto_5

    .line 135
    :cond_8
    :try_start_0
    invoke-virtual {p1}, Landroid/content/Intent;->getDataString()Ljava/lang/String;

    .line 136
    .line 137
    .line 138
    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 139
    goto :goto_4

    .line 140
    :catchall_0
    move-exception v1

    .line 141
    new-instance v6, Ly0i;

    .line 142
    .line 143
    invoke-direct {v6, v1}, Ly0i;-><init>(Ljava/lang/Throwable;)V

    .line 144
    .line 145
    .line 146
    move-object v1, v6

    .line 147
    :goto_4
    instance-of v6, v1, Ly0i;

    .line 148
    .line 149
    if-eqz v6, :cond_9

    .line 150
    .line 151
    move-object v1, v0

    .line 152
    :cond_9
    check-cast v1, Ljava/lang/String;

    .line 153
    .line 154
    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    .line 155
    .line 156
    .line 157
    if-eqz v1, :cond_a

    .line 158
    .line 159
    invoke-static {v1}, Lm1l;->P0(Ljava/lang/CharSequence;)Z

    .line 160
    .line 161
    .line 162
    move-result v1

    .line 163
    :cond_a
    invoke-virtual {p1}, Landroid/content/Intent;->getFlags()I

    .line 164
    .line 165
    .line 166
    move-result p1

    .line 167
    const/16 v1, 0x10

    .line 168
    .line 169
    invoke-static {v1}, Luj1;->G(I)V

    .line 170
    .line 171
    .line 172
    invoke-static {p1, v1}, Ljava/lang/Integer;->toString(II)Ljava/lang/String;

    .line 173
    .line 174
    .line 175
    move-result-object p1

    .line 176
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 177
    .line 178
    .line 179
    :goto_5
    if-eqz v4, :cond_b

    .line 180
    .line 181
    goto :goto_6

    .line 182
    :cond_b
    sget-object p1, Lg8o;->y:Lnh;

    .line 183
    .line 184
    if-eqz p1, :cond_11

    .line 185
    .line 186
    :goto_6
    invoke-virtual {p0}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    .line 187
    .line 188
    .line 189
    move-result-object p1

    .line 190
    invoke-virtual {p0}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    .line 191
    .line 192
    .line 193
    move-result-object v1

    .line 194
    invoke-virtual {v1}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    .line 195
    .line 196
    .line 197
    move-result-object v1

    .line 198
    new-instance v4, Lwmn;

    .line 199
    .line 200
    invoke-direct {v4, p1, v1}, Lwmn;-><init>(Landroid/view/Window;Landroid/view/View;)V

    .line 201
    .line 202
    .line 203
    const/4 p1, 0x0

    .line 204
    invoke-virtual {v4, p1}, Lwmn;->c(Z)V

    .line 205
    .line 206
    .line 207
    invoke-virtual {v4, p1}, Lwmn;->b(Z)V

    .line 208
    .line 209
    .line 210
    sget-object p1, Lybk;->a:Li7l;

    .line 211
    .line 212
    sget-object p1, Las5;->a:Ly2d;

    .line 213
    .line 214
    new-instance p1, Lxbk;

    .line 215
    .line 216
    invoke-direct {p1, v2, v0}, Lk5l;-><init>(ILee3;)V

    .line 217
    .line 218
    .line 219
    invoke-static {p1}, Las5;->a(Lmr6;)V

    .line 220
    .line 221
    .line 222
    sget-object p1, Lym6;->a:Landroid/content/Context;

    .line 223
    .line 224
    if-eqz p1, :cond_10

    .line 225
    .line 226
    sget-object v1, Lym6;->b:Lo3g;

    .line 227
    .line 228
    if-nez v1, :cond_c

    .line 229
    .line 230
    new-instance v1, Lo3g;

    .line 231
    .line 232
    invoke-direct {v1, p1}, Lo3g;-><init>(Landroid/content/Context;)V

    .line 233
    .line 234
    .line 235
    sput-object v1, Lym6;->b:Lo3g;

    .line 236
    .line 237
    :cond_c
    sget-object p1, Lym6;->b:Lo3g;

    .line 238
    .line 239
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 240
    .line 241
    .line 242
    invoke-virtual {p1, p0}, Lo3g;->c(Landroidx/activity/ComponentActivity;)V

    .line 243
    .line 244
    .line 245
    invoke-virtual {p0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    .line 246
    .line 247
    .line 248
    move-result-object p1

    .line 249
    invoke-virtual {p0, p1}, Lcom/xiaoji/egggame/MainActivity;->f(Landroid/content/Intent;)V

    .line 250
    .line 251
    .line 252
    new-instance p1, Lg98;

    .line 253
    .line 254
    const/16 v1, 0x14

    .line 255
    .line 256
    invoke-direct {p1, p0, v1}, Lg98;-><init>(Ljava/lang/Object;I)V

    .line 257
    .line 258
    .line 259
    new-instance v1, Ld23;

    .line 260
    .line 261
    const v2, 0x7385522e

    .line 262
    .line 263
    .line 264
    invoke-direct {v1, v2, p1, v3}, Ld23;-><init>(ILjava/lang/Object;Z)V

    .line 265
    .line 266
    .line 267
    invoke-static {p0, v1}, Le03;->a(Landroidx/activity/ComponentActivity;Ld23;)V

    .line 268
    .line 269
    .line 270
    sget-object p1, Lm4a;->a:Lm4a;

    .line 271
    .line 272
    invoke-static {p1}, Lbao;->B(Lm4a;)V

    .line 273
    .line 274
    .line 275
    sget p1, Landroid/os/Build$VERSION;->SDK_INT:I

    .line 276
    .line 277
    const/16 v1, 0x21

    .line 278
    .line 279
    if-lt p1, v1, :cond_f

    .line 280
    .line 281
    invoke-static {p0}, Lmhd;->v(Lcom/xiaoji/egggame/MainActivity;)V

    .line 282
    .line 283
    .line 284
    sget-object p0, Ls8o;->I:Lh3d;

    .line 285
    .line 286
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 287
    .line 288
    .line 289
    iget-boolean p0, p0, Lh3d;->b:Z

    .line 290
    .line 291
    if-eqz p0, :cond_d

    .line 292
    .line 293
    goto :goto_7

    .line 294
    :cond_d
    sget-object p0, Lg8o;->y:Lnh;

    .line 295
    .line 296
    if-eqz p0, :cond_e

    .line 297
    .line 298
    goto :goto_7

    .line 299
    :cond_e
    invoke-static {v5}, Lmha;->h0(Ljava/lang/String;)V

    .line 300
    .line 301
    .line 302
    throw v0

    .line 303
    :cond_f
    :goto_7
    return-void

    .line 304
    :cond_10
    const-string p0, "PermissionProvider \u672a\u521d\u59cb\u5316\uff0c\u8bf7\u5148\u8c03\u7528 initialize(context)"

    .line 305
    .line 306
    invoke-static {p0}, Lsze;->y(Ljava/lang/String;)V

    .line 307
    .line 308
    .line 309
    return-void

    .line 310
    :cond_11
    invoke-static {v5}, Lmha;->h0(Ljava/lang/String;)V

    .line 311
    .line 312
    .line 313
    throw v0

    .line 314
    :cond_12
    invoke-static {v5}, Lmha;->h0(Ljava/lang/String;)V

    .line 315
    .line 316
    .line 317
    throw v0
.end method

.method public final onDestroy()V
    .locals 5

    .line 1
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    .line 2
    .line 3
    .line 4
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    .line 5
    .line 6
    .line 7
    move-result-object v0

    .line 8
    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    .line 9
    .line 10
    .line 11
    move-result-object v0

    .line 12
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 13
    .line 14
    .line 15
    invoke-static {v0}, Lpl6;->o(Landroid/content/res/Configuration;)Ljava/lang/String;

    .line 16
    .line 17
    .line 18
    move-result-object v0

    .line 19
    new-instance v1, Ljava/lang/StringBuilder;

    .line 20
    .line 21
    const-string v2, "isFinishing="

    .line 22
    .line 23
    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 24
    .line 25
    .line 26
    invoke-virtual {p0}, Landroid/app/Activity;->isFinishing()Z

    .line 27
    .line 28
    .line 29
    move-result v2

    .line 30
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    .line 31
    .line 32
    .line 33
    const-string v2, ", isChangingConfigurations="

    .line 34
    .line 35
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 36
    .line 37
    .line 38
    invoke-virtual {p0}, Landroid/app/Activity;->isChangingConfigurations()Z

    .line 39
    .line 40
    .line 41
    move-result v2

    .line 42
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    .line 43
    .line 44
    .line 45
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 46
    .line 47
    .line 48
    move-result-object v1

    .line 49
    sget-object v2, Lm5j;->c:Lh3d;

    .line 50
    .line 51
    new-instance v3, Ljcc;

    .line 52
    .line 53
    const/16 v4, 0xa

    .line 54
    .line 55
    invoke-direct {v3, p0, v4, v1, v0}, Ljcc;-><init>(Ljava/lang/Object;ILjava/lang/Object;Ljava/lang/Object;)V

    .line 56
    .line 57
    .line 58
    const/4 v0, 0x0

    .line 59
    invoke-static {v2, v0, v3}, Lnmi;->s(Li3d;Ljava/lang/Throwable;Lwq6;)V

    .line 60
    .line 61
    .line 62
    invoke-super {p0}, Lcom/xiaoji/egggame/core/android/base/BaseActivity;->onDestroy()V

    .line 63
    .line 64
    .line 65
    return-void
.end method

.method public final onNewIntent(Landroid/content/Intent;)V
    .locals 1

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 2
    .line 3
    .line 4
    invoke-super {p0, p1}, Landroidx/activity/ComponentActivity;->onNewIntent(Landroid/content/Intent;)V

    .line 5
    .line 6
    .line 7
    sget-object v0, Lm5j;->c:Lh3d;

    .line 8
    .line 9
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 10
    .line 11
    .line 12
    iget-boolean v0, v0, Lh3d;->b:Z

    .line 13
    .line 14
    if-eqz v0, :cond_0

    .line 15
    .line 16
    goto :goto_0

    .line 17
    :cond_0
    sget-object v0, Lg8o;->y:Lnh;

    .line 18
    .line 19
    if-eqz v0, :cond_1

    .line 20
    .line 21
    :goto_0
    invoke-virtual {p0, p1}, Landroid/app/Activity;->setIntent(Landroid/content/Intent;)V

    .line 22
    .line 23
    .line 24
    invoke-virtual {p0, p1}, Lcom/xiaoji/egggame/MainActivity;->f(Landroid/content/Intent;)V

    .line 25
    .line 26
    .line 27
    return-void

    .line 28
    :cond_1
    const-string p0, "info"

    .line 29
    .line 30
    invoke-static {p0}, Lmha;->h0(Ljava/lang/String;)V

    .line 31
    .line 32
    .line 33
    const/4 p0, 0x0

    .line 34
    throw p0
.end method

.method public final onPause()V
    .locals 0

    .line 1
    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    .line 2
    .line 3
    .line 4
    sget-object p0, Lm5j;->c:Lh3d;

    .line 5
    .line 6
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 7
    .line 8
    .line 9
    iget-boolean p0, p0, Lh3d;->b:Z

    .line 10
    .line 11
    if-eqz p0, :cond_0

    .line 12
    .line 13
    goto :goto_0

    .line 14
    :cond_0
    sget-object p0, Lg8o;->y:Lnh;

    .line 15
    .line 16
    if-eqz p0, :cond_1

    .line 17
    .line 18
    :goto_0
    return-void

    .line 19
    :cond_1
    const-string p0, "info"

    .line 20
    .line 21
    invoke-static {p0}, Lmha;->h0(Ljava/lang/String;)V

    .line 22
    .line 23
    .line 24
    const/4 p0, 0x0

    .line 25
    throw p0
.end method

.method public final onRestoreInstanceState(Landroid/os/Bundle;)V
    .locals 0

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 2
    .line 3
    .line 4
    invoke-super {p0, p1}, Landroid/app/Activity;->onRestoreInstanceState(Landroid/os/Bundle;)V

    .line 5
    .line 6
    .line 7
    sget-object p0, Lm5j;->c:Lh3d;

    .line 8
    .line 9
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 10
    .line 11
    .line 12
    iget-boolean p0, p0, Lh3d;->b:Z

    .line 13
    .line 14
    if-eqz p0, :cond_0

    .line 15
    .line 16
    goto :goto_0

    .line 17
    :cond_0
    sget-object p0, Lg8o;->y:Lnh;

    .line 18
    .line 19
    if-eqz p0, :cond_1

    .line 20
    .line 21
    :goto_0
    return-void

    .line 22
    :cond_1
    const-string p0, "info"

    .line 23
    .line 24
    invoke-static {p0}, Lmha;->h0(Ljava/lang/String;)V

    .line 25
    .line 26
    .line 27
    const/4 p0, 0x0

    .line 28
    throw p0
.end method

.method public final onResume()V
    .locals 0

    .line 1
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 2
    .line 3
    .line 4
    sget-object p0, Lm5j;->c:Lh3d;

    .line 5
    .line 6
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 7
    .line 8
    .line 9
    iget-boolean p0, p0, Lh3d;->b:Z

    .line 10
    .line 11
    if-eqz p0, :cond_0

    .line 12
    .line 13
    goto :goto_0

    .line 14
    :cond_0
    sget-object p0, Lg8o;->y:Lnh;

    .line 15
    .line 16
    if-eqz p0, :cond_1

    .line 17
    .line 18
    :goto_0
    return-void

    .line 19
    :cond_1
    const-string p0, "info"

    .line 20
    .line 21
    invoke-static {p0}, Lmha;->h0(Ljava/lang/String;)V

    .line 22
    .line 23
    .line 24
    const/4 p0, 0x0

    .line 25
    throw p0
.end method

.method public final onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 1

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 2
    .line 3
    .line 4
    sget-object v0, Lm5j;->c:Lh3d;

    .line 5
    .line 6
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 7
    .line 8
    .line 9
    iget-boolean v0, v0, Lh3d;->b:Z

    .line 10
    .line 11
    if-eqz v0, :cond_0

    .line 12
    .line 13
    goto :goto_0

    .line 14
    :cond_0
    sget-object v0, Lg8o;->y:Lnh;

    .line 15
    .line 16
    if-eqz v0, :cond_1

    .line 17
    .line 18
    :goto_0
    invoke-super {p0, p1}, Landroidx/activity/ComponentActivity;->onSaveInstanceState(Landroid/os/Bundle;)V

    .line 19
    .line 20
    .line 21
    return-void

    .line 22
    :cond_1
    const-string p0, "info"

    .line 23
    .line 24
    invoke-static {p0}, Lmha;->h0(Ljava/lang/String;)V

    .line 25
    .line 26
    .line 27
    const/4 p0, 0x0

    .line 28
    throw p0
.end method

.method public final onStart()V
    .locals 0

    .line 1
    invoke-super {p0}, Landroid/app/Activity;->onStart()V

    .line 2
    .line 3
    .line 4
    sget-object p0, Lm5j;->c:Lh3d;

    .line 5
    .line 6
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 7
    .line 8
    .line 9
    iget-boolean p0, p0, Lh3d;->b:Z

    .line 10
    .line 11
    if-eqz p0, :cond_0

    .line 12
    .line 13
    goto :goto_0

    .line 14
    :cond_0
    sget-object p0, Lg8o;->y:Lnh;

    .line 15
    .line 16
    if-eqz p0, :cond_1

    .line 17
    .line 18
    :goto_0
    return-void

    .line 19
    :cond_1
    const-string p0, "info"

    .line 20
    .line 21
    invoke-static {p0}, Lmha;->h0(Ljava/lang/String;)V

    .line 22
    .line 23
    .line 24
    const/4 p0, 0x0

    .line 25
    throw p0
.end method

.method public final onStop()V
    .locals 0

    .line 1
    invoke-super {p0}, Landroid/app/Activity;->onStop()V

    .line 2
    .line 3
    .line 4
    sget-object p0, Lm5j;->c:Lh3d;

    .line 5
    .line 6
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 7
    .line 8
    .line 9
    iget-boolean p0, p0, Lh3d;->b:Z

    .line 10
    .line 11
    if-eqz p0, :cond_0

    .line 12
    .line 13
    goto :goto_0

    .line 14
    :cond_0
    sget-object p0, Lg8o;->y:Lnh;

    .line 15
    .line 16
    if-eqz p0, :cond_1

    .line 17
    .line 18
    :goto_0
    return-void

    .line 19
    :cond_1
    const-string p0, "info"

    .line 20
    .line 21
    invoke-static {p0}, Lmha;->h0(Ljava/lang/String;)V

    .line 22
    .line 23
    .line 24
    const/4 p0, 0x0

    .line 25
    throw p0
.end method

.method public final recreate()V
    .locals 7

    .line 1
    new-instance v0, Ljava/lang/Throwable;

    .line 2
    .line 3
    const-string v1, "recreate() called"

    .line 4
    .line 5
    invoke-direct {v0, v1}, Ljava/lang/Throwable;-><init>(Ljava/lang/String;)V

    .line 6
    .line 7
    .line 8
    invoke-virtual {v0}, Ljava/lang/Throwable;->getStackTrace()[Ljava/lang/StackTraceElement;

    .line 9
    .line 10
    .line 11
    move-result-object v0

    .line 12
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 13
    .line 14
    .line 15
    array-length v1, v0

    .line 16
    const/16 v2, 0x12

    .line 17
    .line 18
    if-lt v2, v1, :cond_0

    .line 19
    .line 20
    invoke-static {v0}, Lvl0;->R0([Ljava/lang/Object;)Ljava/util/List;

    .line 21
    .line 22
    .line 23
    move-result-object v0

    .line 24
    goto :goto_0

    .line 25
    :cond_0
    const/4 v1, 0x0

    .line 26
    invoke-static {v0, v1, v2}, Lvl0;->Z([Ljava/lang/Object;II)[Ljava/lang/Object;

    .line 27
    .line 28
    .line 29
    move-result-object v0

    .line 30
    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    .line 31
    .line 32
    .line 33
    move-result-object v0

    .line 34
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 35
    .line 36
    .line 37
    :goto_0
    move-object v1, v0

    .line 38
    check-cast v1, Ljava/lang/Iterable;

    .line 39
    .line 40
    new-instance v5, Lm0d;

    .line 41
    .line 42
    const/16 v0, 0x17

    .line 43
    .line 44
    invoke-direct {v5, v0}, Lm0d;-><init>(I)V

    .line 45
    .line 46
    .line 47
    const/16 v6, 0x1e

    .line 48
    .line 49
    const-string v2, "\n"

    .line 50
    .line 51
    const/4 v3, 0x0

    .line 52
    const/4 v4, 0x0

    .line 53
    invoke-static/range {v1 .. v6}, Ltq2;->K0(Ljava/lang/Iterable;Ljava/lang/CharSequence;Ljava/lang/String;Ljava/lang/String;Lyq6;I)Ljava/lang/String;

    .line 54
    .line 55
    .line 56
    move-result-object v0

    .line 57
    sget-object v1, Lm5j;->c:Lh3d;

    .line 58
    .line 59
    new-instance v2, Lobc;

    .line 60
    .line 61
    const/16 v3, 0x13

    .line 62
    .line 63
    invoke-direct {v2, v3, p0, v0}, Lobc;-><init>(ILjava/lang/Object;Ljava/lang/Object;)V

    .line 64
    .line 65
    .line 66
    const/4 v0, 0x0

    .line 67
    invoke-static {v1, v0, v2}, Lnmi;->s(Li3d;Ljava/lang/Throwable;Lwq6;)V

    .line 68
    .line 69
    .line 70
    invoke-super {p0}, Landroid/app/Activity;->recreate()V

    .line 71
    .line 72
    .line 73
    return-void
.end method
