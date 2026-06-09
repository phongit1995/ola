.class public Lchat/ola/vn/lock/c;
.super Lchat/ola/vn/lock/a;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field w:Lchat/ola/vn/lock/d;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/lock/a;-><init>()V

    return-void
.end method


# virtual methods
.method public c()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f044d

    :try_start_0
    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public d()Ljava/lang/String;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method public e()V
    .locals 2

    invoke-virtual {p0}, Lchat/ola/vn/lock/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const-class v1, Lchat/ola/vn/lock/e;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/lock/e;

    iput-object v0, p0, Lchat/ola/vn/lock/c;->w:Lchat/ola/vn/lock/d;

    invoke-virtual {p0}, Lchat/ola/vn/lock/c;->y()Lchat/ola/vn/lock/OlaPasscodeSettingActivity;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->B()V

    return-void
.end method

.method protected e(Ljava/lang/String;)Z
    .locals 2

    invoke-virtual {p0}, Lchat/ola/vn/lock/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const-class v1, Lchat/ola/vn/lock/f;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/lock/f;

    iput-object v0, p0, Lchat/ola/vn/lock/c;->w:Lchat/ola/vn/lock/d;

    sput-object p1, Lchat/ola/vn/lock/f;->w:Ljava/lang/String;

    invoke-virtual {p0}, Lchat/ola/vn/lock/c;->y()Lchat/ola/vn/lock/OlaPasscodeSettingActivity;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->B()V

    const/4 p1, 0x1

    return p1
.end method

.method public e_()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f0621

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public h()Lchat/ola/vn/lock/d;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/lock/c;->w:Lchat/ola/vn/lock/d;

    return-object v0
.end method

.method public j()Lchat/ola/vn/lock/d;
    .locals 2

    invoke-virtual {p0}, Lchat/ola/vn/lock/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const-class v1, Lchat/ola/vn/lock/e;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/lock/e;

    return-object v0
.end method
