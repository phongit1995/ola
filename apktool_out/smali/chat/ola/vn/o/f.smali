.class public Lchat/ola/vn/o/f;
.super Lchat/ola/vn/entry/e;


# direct methods
.method public constructor <init>()V
    .locals 2

    const v0, 0x7f0f00f9

    const v1, 0x7f08079d

    invoke-direct {p0, v0, v1, v0}, Lchat/ola/vn/entry/e;-><init>(III)V

    return-void
.end method


# virtual methods
.method public b(Landroid/content/Context;)Z
    .locals 0

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/activity/OlaAppSettingActivity;->c(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p1, 0x1

    return p1

    :catch_0
    const/4 p1, 0x0

    return p1
.end method
