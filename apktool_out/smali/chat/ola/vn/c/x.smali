.class public Lchat/ola/vn/c/x;
.super Ljava/lang/Object;


# static fields
.field private static A:Ljava/lang/String; = null

.field private static B:Ljava/util/Calendar; = null

.field public static a:J = 0x0L

.field public static b:Ljava/lang/Boolean; = null

.field public static c:Ljava/lang/String; = null

.field public static d:Ljava/lang/String; = null

.field public static e:Ljava/lang/Short; = null

.field public static f:J = 0xdbba0L

.field public static g:J = 0x2bf20L

.field public static h:Z = true

.field public static i:I = 0x5

.field public static j:S = 0x2s

.field public static k:B = 0x0t

.field public static l:B = 0x0t

.field public static m:B = 0x0t

.field public static n:B = 0x0t

.field public static o:B = 0x0t

.field public static p:B = 0x0t

.field public static q:Z = true

.field public static r:Z = true

.field public static s:Z = false

.field public static t:Z = true

.field public static u:Z = true

.field public static v:Z = false

.field public static w:Z = true

.field public static x:Z = true

.field public static y:Z = false

.field private static z:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public static a(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    sput-object p0, Lchat/ola/vn/c/x;->z:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p0

    sget-object v0, Lchat/ola/vn/c/x;->z:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lchat/ola/vn/e;->o(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static a()Z
    .locals 1

    invoke-static {}, Lchat/ola/vn/h;->i()Z

    move-result v0

    return v0
.end method

.method public static b(Ljava/lang/String;)V
    .locals 1

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string p0, "default"

    :cond_0
    sput-object p0, Lchat/ola/vn/c/x;->A:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    invoke-virtual {v0, p0}, Lchat/ola/vn/e;->d(Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/OlaApplication;->c()V

    return-void
.end method

.method public static b()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public static c()Ljava/lang/String;
    .locals 1

    :try_start_0
    sget-object v0, Lchat/ola/vn/c/x;->z:Ljava/lang/String;

    if-nez v0, :cond_0

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/e;->u()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/c/x;->z:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    sget-object v0, Lchat/ola/vn/c/x;->z:Ljava/lang/String;

    return-object v0
.end method

.method public static d()Landroid/net/Uri;
    .locals 2

    :try_start_0
    invoke-static {}, Lchat/ola/vn/c/x;->c()Ljava/lang/String;

    move-result-object v0

    const-string v1, "ola"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lchat/ola/vn/util/c/a;->j:Landroid/net/Uri;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    :cond_0
    sget-object v0, Lchat/ola/vn/util/c/a;->i:Landroid/net/Uri;

    return-object v0
.end method

.method public static e()Z
    .locals 9

    sget-object v0, Lchat/ola/vn/c/x;->B:Ljava/util/Calendar;

    if-nez v0, :cond_0

    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/c/x;->B:Ljava/util/Calendar;

    :cond_0
    sget-object v0, Lchat/ola/vn/c/x;->B:Ljava/util/Calendar;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/util/Calendar;->setTimeInMillis(J)V

    sget-object v0, Lchat/ola/vn/c/x;->B:Ljava/util/Calendar;

    const/16 v1, 0xb

    invoke-virtual {v0, v1}, Ljava/util/Calendar;->get(I)I

    move-result v0

    sget-object v1, Lchat/ola/vn/c/x;->B:Ljava/util/Calendar;

    const/16 v2, 0xc

    invoke-virtual {v1, v2}, Ljava/util/Calendar;->get(I)I

    move-result v1

    sget-byte v3, Lchat/ola/vn/c/x;->n:B

    const/16 v4, 0x16

    const/4 v5, 0x6

    const/16 v6, 0x1e

    const/16 v7, 0xd

    const/4 v8, 0x0

    packed-switch v3, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    const/16 v1, 0x8

    if-lt v0, v1, :cond_8

    const/16 v1, 0x11

    if-gt v0, v1, :cond_8

    return v8

    :pswitch_1
    if-lt v0, v2, :cond_2

    if-gt v0, v7, :cond_2

    if-ne v0, v7, :cond_1

    if-gt v1, v6, :cond_8

    :cond_1
    return v8

    :cond_2
    if-le v0, v5, :cond_3

    if-lt v0, v4, :cond_8

    :cond_3
    if-ne v0, v5, :cond_4

    if-gt v1, v6, :cond_8

    :cond_4
    return v8

    :pswitch_2
    if-le v0, v5, :cond_5

    if-lt v0, v4, :cond_8

    :cond_5
    if-ne v0, v5, :cond_6

    if-gt v1, v6, :cond_8

    :cond_6
    return v8

    :pswitch_3
    if-lt v0, v2, :cond_8

    if-gt v0, v7, :cond_8

    if-ne v0, v7, :cond_7

    if-gt v1, v6, :cond_8

    :cond_7
    :pswitch_4
    return v8

    :cond_8
    :goto_0
    const/4 v0, 0x1

    return v0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public static f()Z
    .locals 9

    sget-object v0, Lchat/ola/vn/c/x;->B:Ljava/util/Calendar;

    if-nez v0, :cond_0

    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/c/x;->B:Ljava/util/Calendar;

    :cond_0
    sget-object v0, Lchat/ola/vn/c/x;->B:Ljava/util/Calendar;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/util/Calendar;->setTimeInMillis(J)V

    sget-object v0, Lchat/ola/vn/c/x;->B:Ljava/util/Calendar;

    const/16 v1, 0xb

    invoke-virtual {v0, v1}, Ljava/util/Calendar;->get(I)I

    move-result v0

    sget-object v1, Lchat/ola/vn/c/x;->B:Ljava/util/Calendar;

    const/16 v2, 0xc

    invoke-virtual {v1, v2}, Ljava/util/Calendar;->get(I)I

    move-result v1

    sget-byte v3, Lchat/ola/vn/c/x;->o:B

    const/16 v4, 0x16

    const/4 v5, 0x6

    const/16 v6, 0x1e

    const/16 v7, 0xd

    const/4 v8, 0x0

    packed-switch v3, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    const/16 v1, 0x8

    if-lt v0, v1, :cond_8

    const/16 v1, 0x11

    if-gt v0, v1, :cond_8

    return v8

    :pswitch_1
    if-lt v0, v2, :cond_2

    if-gt v0, v7, :cond_2

    if-ne v0, v7, :cond_1

    if-gt v1, v6, :cond_8

    :cond_1
    return v8

    :cond_2
    if-le v0, v5, :cond_3

    if-lt v0, v4, :cond_8

    :cond_3
    if-ne v0, v5, :cond_4

    if-gt v1, v6, :cond_8

    :cond_4
    return v8

    :pswitch_2
    if-le v0, v5, :cond_5

    if-lt v0, v4, :cond_8

    :cond_5
    if-ne v0, v5, :cond_6

    if-gt v1, v6, :cond_8

    :cond_6
    return v8

    :pswitch_3
    if-lt v0, v2, :cond_8

    if-gt v0, v7, :cond_8

    if-ne v0, v7, :cond_7

    if-gt v1, v6, :cond_8

    :cond_7
    :pswitch_4
    return v8

    :cond_8
    :goto_0
    const/4 v0, 0x1

    return v0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public static g()V
    .locals 3

    sget-short v0, Lchat/ola/vn/c/x;->j:S

    const/16 v1, 0x4000

    and-int/2addr v0, v1

    const/4 v2, 0x2

    if-eq v0, v1, :cond_0

    sput-short v2, Lchat/ola/vn/c/x;->j:S

    :cond_0
    const/4 v0, 0x0

    sput-byte v0, Lchat/ola/vn/c/x;->k:B

    sput-byte v2, Lchat/ola/vn/c/x;->m:B

    const/4 v1, 0x3

    sput-byte v1, Lchat/ola/vn/c/x;->n:B

    const/4 v1, 0x1

    sput-boolean v1, Lchat/ola/vn/c/x;->h:Z

    sput-byte v0, Lchat/ola/vn/c/x;->o:B

    sput-boolean v1, Lchat/ola/vn/c/x;->q:Z

    sput-byte v0, Lchat/ola/vn/c/x;->l:B

    const/4 v2, 0x0

    sput-object v2, Lchat/ola/vn/c/x;->c:Ljava/lang/String;

    sput-boolean v1, Lchat/ola/vn/c/x;->t:Z

    sput-byte v0, Lchat/ola/vn/c/x;->p:B

    return-void
.end method

.method public static h()V
    .locals 5

    :try_start_0
    new-instance v0, Lchat/ola/vn/entity/aa;

    invoke-direct {v0}, Lchat/ola/vn/entity/aa;-><init>()V

    const-string v1, "usersettings"

    iput-object v1, v0, Lchat/ola/vn/entity/aa;->a:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/h/b;->f()[B

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/entity/aa;->b:[B

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const-string v2, "set"

    const/4 v3, 0x1

    new-array v3, v3, [Lchat/ola/vn/entity/aa;

    const/4 v4, 0x0

    aput-object v0, v3, v4

    invoke-virtual {v1, v2, v3, v4}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;[Lchat/ola/vn/entity/aa;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static i()Ljava/lang/String;
    .locals 2

    :try_start_0
    sget-object v0, Lchat/ola/vn/c/x;->A:Ljava/lang/String;

    if-nez v0, :cond_0

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/e;->l()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/c/x;->A:Ljava/lang/String;

    :cond_0
    sget-object v0, Lchat/ola/vn/c/x;->A:Ljava/lang/String;

    const-string v1, "default"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v0

    :cond_1
    const-string v1, "vi"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    const-string v0, "vi"

    return-object v0

    :cond_2
    const-string v0, "en"
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const-string v0, "en"

    return-object v0
.end method
