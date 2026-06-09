.class public Lchat/ola/vn/lock/f;
.super Lchat/ola/vn/lock/a;

# interfaces
.implements Landroid/view/View$OnClickListener;


# static fields
.field static w:Ljava/lang/String; = ""


# instance fields
.field y:Lchat/ola/vn/lock/d;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/lock/a;-><init>()V

    return-void
.end method


# virtual methods
.method protected b(Landroid/os/Bundle;)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/lock/a;->b(Landroid/os/Bundle;)V

    iget-object p1, p0, Lchat/ola/vn/lock/f;->u:Landroid/widget/TextView;

    const v0, 0x7f0f05d9

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

    invoke-virtual {p0}, Lchat/ola/vn/lock/f;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const-class v1, Lchat/ola/vn/lock/e;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/lock/e;

    iput-object v0, p0, Lchat/ola/vn/lock/f;->y:Lchat/ola/vn/lock/d;

    invoke-virtual {p0}, Lchat/ola/vn/lock/f;->y()Lchat/ola/vn/lock/OlaPasscodeSettingActivity;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->B()V

    return-void
.end method

.method protected e(Ljava/lang/String;)Z
    .locals 2

    sget-object v0, Lchat/ola/vn/lock/f;->w:Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    sget-object v0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->e:Lchat/ola/vn/entity/r;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/entity/r;

    invoke-direct {v0}, Lchat/ola/vn/entity/r;-><init>()V

    sput-object v0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->e:Lchat/ola/vn/entity/r;

    :cond_0
    sget-object v0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->e:Lchat/ola/vn/entity/r;

    iput-object p1, v0, Lchat/ola/vn/entity/r;->a:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->e:Lchat/ola/vn/entity/r;

    invoke-virtual {v0}, Lchat/ola/vn/entity/r;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/e;->p(Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/lock/f;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const-class v0, Lchat/ola/vn/lock/e;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/lock/e;

    iput-object p1, p0, Lchat/ola/vn/lock/f;->y:Lchat/ola/vn/lock/d;

    invoke-virtual {p0}, Lchat/ola/vn/lock/f;->y()Lchat/ola/vn/lock/OlaPasscodeSettingActivity;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->B()V

    return v1

    :cond_1
    new-instance p1, Landroid/os/Bundle;

    invoke-direct {p1}, Landroid/os/Bundle;-><init>()V

    const-string v0, "passCodeIndicatorTextView"

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    invoke-virtual {p0}, Lchat/ola/vn/lock/f;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const-class v1, Lchat/ola/vn/lock/c;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1, p1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;Landroid/os/Bundle;)Landroid/support/v4/app/Fragment;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/lock/c;

    iput-object p1, p0, Lchat/ola/vn/lock/f;->y:Lchat/ola/vn/lock/d;

    invoke-virtual {p0}, Lchat/ola/vn/lock/f;->y()Lchat/ola/vn/lock/OlaPasscodeSettingActivity;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->B()V

    const/4 p1, 0x0

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

    iget-object v0, p0, Lchat/ola/vn/lock/f;->y:Lchat/ola/vn/lock/d;

    return-object v0
.end method
