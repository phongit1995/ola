.class public Lchat/ola/vn/util/j;
.super Ljava/lang/Object;


# static fields
.field private static a:J

.field private static b:J


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public static a(J)V
    .locals 0

    sput-wide p0, Lchat/ola/vn/util/j;->b:J

    return-void
.end method

.method public static a(Landroid/content/Context;I)V
    .locals 1

    const/4 v0, 0x1

    invoke-static {p0, p1, v0}, Lchat/ola/vn/util/j;->a(Landroid/content/Context;IZ)V

    return-void
.end method

.method private static a(Landroid/content/Context;IZ)V
    .locals 6

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    if-nez p2, :cond_1

    sget-wide v2, Lchat/ola/vn/util/j;->a:J

    const/4 p2, 0x0

    sub-long v4, v0, v2

    sget-wide v2, Lchat/ola/vn/util/j;->b:J

    cmp-long p2, v4, v2

    if-gez p2, :cond_1

    return-void

    :cond_1
    sput-wide v0, Lchat/ola/vn/util/j;->a:J

    const/4 p2, 0x1

    new-array p2, p2, [Ljava/lang/Object;

    const-string v0, ""

    const/4 v1, 0x0

    aput-object v0, p2, v1

    invoke-virtual {p0, p1, p2}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p0

    invoke-virtual {p0}, Landroid/widget/Toast;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private static varargs a(Landroid/content/Context;IZ[Ljava/lang/Object;)V
    .locals 6

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    if-nez p2, :cond_1

    sget-wide v2, Lchat/ola/vn/util/j;->a:J

    const/4 p2, 0x0

    sub-long v4, v0, v2

    sget-wide v2, Lchat/ola/vn/util/j;->b:J

    cmp-long p2, v4, v2

    if-gez p2, :cond_1

    return-void

    :cond_1
    sput-wide v0, Lchat/ola/vn/util/j;->a:J

    invoke-virtual {p0, p1, p3}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    const/4 p2, 0x0

    invoke-static {p0, p1, p2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p0

    invoke-virtual {p0}, Landroid/widget/Toast;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static varargs a(Landroid/content/Context;I[Ljava/lang/Object;)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, p1, v0, p2}, Lchat/ola/vn/util/j;->a(Landroid/content/Context;IZ[Ljava/lang/Object;)V

    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lchat/ola/vn/util/j;->a(Landroid/content/Context;Ljava/lang/String;Z)V

    return-void
.end method

.method private static a(Landroid/content/Context;Ljava/lang/String;Z)V
    .locals 6

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    if-nez p2, :cond_1

    sget-wide v2, Lchat/ola/vn/util/j;->a:J

    const/4 p2, 0x0

    sub-long v4, v0, v2

    sget-wide v2, Lchat/ola/vn/util/j;->b:J

    cmp-long p2, v4, v2

    if-gez p2, :cond_1

    return-void

    :cond_1
    sput-wide v0, Lchat/ola/vn/util/j;->a:J

    const/4 p2, 0x0

    invoke-static {p0, p1, p2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p0

    invoke-virtual {p0}, Landroid/widget/Toast;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static b(Landroid/content/Context;I)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lchat/ola/vn/util/j;->a(Landroid/content/Context;IZ)V

    return-void
.end method

.method private static b(Landroid/content/Context;IZ)V
    .locals 6

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    if-nez p2, :cond_1

    sget-wide v2, Lchat/ola/vn/util/j;->a:J

    const/4 p2, 0x0

    sub-long v4, v0, v2

    sget-wide v2, Lchat/ola/vn/util/j;->b:J

    cmp-long p2, v4, v2

    if-gez p2, :cond_1

    return-void

    :cond_1
    sput-wide v0, Lchat/ola/vn/util/j;->a:J

    invoke-virtual {p0, p1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p1

    const/4 p2, 0x1

    invoke-static {p0, p1, p2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p0

    invoke-virtual {p0}, Landroid/widget/Toast;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private static varargs b(Landroid/content/Context;IZ[Ljava/lang/Object;)V
    .locals 6

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    if-nez p2, :cond_1

    sget-wide v2, Lchat/ola/vn/util/j;->a:J

    const/4 p2, 0x0

    sub-long v4, v0, v2

    sget-wide v2, Lchat/ola/vn/util/j;->b:J

    cmp-long p2, v4, v2

    if-gez p2, :cond_1

    return-void

    :cond_1
    sput-wide v0, Lchat/ola/vn/util/j;->a:J

    invoke-virtual {p0, p1, p3}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    const/4 p2, 0x1

    invoke-static {p0, p1, p2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p0

    invoke-virtual {p0}, Landroid/widget/Toast;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static varargs b(Landroid/content/Context;I[Ljava/lang/Object;)V
    .locals 1

    const/4 v0, 0x1

    invoke-static {p0, p1, v0, p2}, Lchat/ola/vn/util/j;->a(Landroid/content/Context;IZ[Ljava/lang/Object;)V

    return-void
.end method

.method public static b(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x1

    invoke-static {p0, p1, v0}, Lchat/ola/vn/util/j;->a(Landroid/content/Context;Ljava/lang/String;Z)V

    return-void
.end method

.method private static b(Landroid/content/Context;Ljava/lang/String;Z)V
    .locals 6

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    if-nez p2, :cond_1

    sget-wide v2, Lchat/ola/vn/util/j;->a:J

    const/4 p2, 0x0

    sub-long v4, v0, v2

    sget-wide v2, Lchat/ola/vn/util/j;->b:J

    cmp-long p2, v4, v2

    if-gez p2, :cond_1

    return-void

    :cond_1
    sput-wide v0, Lchat/ola/vn/util/j;->a:J

    const/4 p2, 0x1

    invoke-static {p0, p1, p2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p0

    invoke-virtual {p0}, Landroid/widget/Toast;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static c(Landroid/content/Context;I)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lchat/ola/vn/util/j;->b(Landroid/content/Context;IZ)V

    return-void
.end method

.method public static varargs c(Landroid/content/Context;I[Ljava/lang/Object;)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, p1, v0, p2}, Lchat/ola/vn/util/j;->b(Landroid/content/Context;IZ[Ljava/lang/Object;)V

    return-void
.end method

.method public static c(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x1

    invoke-static {p0, p1, v0}, Lchat/ola/vn/util/j;->b(Landroid/content/Context;Ljava/lang/String;Z)V

    return-void
.end method

.method public static d(Landroid/content/Context;I)V
    .locals 1

    const/4 v0, 0x1

    invoke-static {p0, p1, v0}, Lchat/ola/vn/util/j;->b(Landroid/content/Context;IZ)V

    return-void
.end method

.method public static varargs d(Landroid/content/Context;I[Ljava/lang/Object;)V
    .locals 1

    const/4 v0, 0x1

    invoke-static {p0, p1, v0, p2}, Lchat/ola/vn/util/j;->b(Landroid/content/Context;IZ[Ljava/lang/Object;)V

    return-void
.end method
