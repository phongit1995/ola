.class public Lchat/ola/vn/lock/g;
.super Lchat/ola/vn/lock/a;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field w:Lchat/ola/vn/lock/e;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/lock/a;-><init>()V

    return-void
.end method


# virtual methods
.method protected b(Landroid/os/Bundle;)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/lock/a;->b(Landroid/os/Bundle;)V

    iget-object p1, p0, Lchat/ola/vn/lock/g;->u:Landroid/widget/TextView;

    const v0, 0x7f0f04e3

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(I)V

    return-void
.end method

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

    invoke-virtual {p0}, Lchat/ola/vn/lock/g;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const-class v1, Lchat/ola/vn/lock/e;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/lock/e;

    iput-object v0, p0, Lchat/ola/vn/lock/g;->w:Lchat/ola/vn/lock/e;

    invoke-virtual {p0}, Lchat/ola/vn/lock/g;->y()Lchat/ola/vn/lock/OlaPasscodeSettingActivity;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->B()V

    return-void
.end method

.method public e_()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f0661

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public h()Lchat/ola/vn/lock/d;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/lock/g;->w:Lchat/ola/vn/lock/e;

    return-object v0
.end method

.method public j()Lchat/ola/vn/lock/d;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/lock/g;->x:Lchat/ola/vn/lock/d;

    return-object v0
.end method

.method protected v()V
    .locals 2

    :try_start_0
    sget-object v0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->e:Lchat/ola/vn/entity/r;

    const-string v1, ""

    iput-object v1, v0, Lchat/ola/vn/entity/r;->a:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->e:Lchat/ola/vn/entity/r;

    invoke-virtual {v1}, Lchat/ola/vn/entity/r;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/e;->p(Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/lock/g;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const-class v1, Lchat/ola/vn/lock/e;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/lock/e;

    iput-object v0, p0, Lchat/ola/vn/lock/g;->w:Lchat/ola/vn/lock/e;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
