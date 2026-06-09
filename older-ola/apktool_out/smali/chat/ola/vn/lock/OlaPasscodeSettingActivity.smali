.class public Lchat/ola/vn/lock/OlaPasscodeSettingActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;


# static fields
.field static e:Lchat/ola/vn/entity/r;


# instance fields
.field private f:Lchat/ola/vn/lock/d;

.field private g:Landroid/widget/TextView;

.field private h:Landroid/widget/TextView;

.field private i:Landroid/widget/TextView;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    return-void
.end method

.method public static a(Landroid/content/Context;)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    :try_start_0
    check-cast p0, Landroid/app/Activity;

    const v0, 0x7f010038

    const v1, 0x7f010039

    invoke-virtual {p0, v0, v1}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public B()V
    .locals 5

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->f:Lchat/ola/vn/lock/d;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->f:Lchat/ola/vn/lock/d;

    invoke-virtual {v1}, Lchat/ola/vn/lock/d;->h()Lchat/ola/vn/lock/d;

    move-result-object v1

    if-eqz v1, :cond_0

    const v2, 0x7f01000d

    const v3, 0x7f01000e

    invoke-virtual {v0, v2, v3}, Landroid/support/v4/app/FragmentTransaction;->setCustomAnimations(II)Landroid/support/v4/app/FragmentTransaction;

    const v2, 0x7f0903a9

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v1, v3}, Landroid/support/v4/app/FragmentTransaction;->replace(ILandroid/support/v4/app/Fragment;Ljava/lang/String;)Landroid/support/v4/app/FragmentTransaction;

    iget-object v2, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->f:Lchat/ola/vn/lock/d;

    invoke-virtual {v1, v2}, Lchat/ola/vn/lock/d;->a(Lchat/ola/vn/lock/d;)V

    invoke-virtual {v1}, Lchat/ola/vn/lock/d;->e_()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1}, Lchat/ola/vn/lock/d;->d()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1}, Lchat/ola/vn/lock/d;->c()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v2, v3, v4}, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iput-object v1, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->f:Lchat/ola/vn/lock/d;

    :cond_0
    invoke-virtual {v0}, Landroid/support/v4/app/FragmentTransaction;->commit()I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public C()Lchat/ola/vn/lock/d;
    .locals 5

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->f:Lchat/ola/vn/lock/d;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->f:Lchat/ola/vn/lock/d;

    invoke-virtual {v1}, Lchat/ola/vn/lock/d;->j()Lchat/ola/vn/lock/d;

    move-result-object v1

    if-eqz v1, :cond_0

    const v2, 0x7f01000a

    const v3, 0x7f01000c

    invoke-virtual {v0, v2, v3}, Landroid/support/v4/app/FragmentTransaction;->setCustomAnimations(II)Landroid/support/v4/app/FragmentTransaction;

    const v2, 0x7f0903a9

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v1, v3}, Landroid/support/v4/app/FragmentTransaction;->replace(ILandroid/support/v4/app/Fragment;Ljava/lang/String;)Landroid/support/v4/app/FragmentTransaction;

    invoke-virtual {v1}, Lchat/ola/vn/lock/d;->e_()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1}, Lchat/ola/vn/lock/d;->d()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1}, Lchat/ola/vn/lock/d;->c()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v2, v3, v4}, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentTransaction;->commit()I

    :cond_0
    iput-object v1, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->f:Lchat/ola/vn/lock/d;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->f:Lchat/ola/vn/lock/d;

    return-object v0
.end method

.method protected a()V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->g:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    const/4 v0, 0x4

    const/4 v1, 0x0

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->i:Landroid/widget/TextView;

    invoke-virtual {p1, p3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->i:Landroid/widget/TextView;

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->i:Landroid/widget/TextView;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_0
    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->h:Landroid/widget/TextView;

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->h:Landroid/widget/TextView;

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setVisibility(I)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->h:Landroid/widget/TextView;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onBackPressed()V
    .locals 1

    invoke-virtual {p0}, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->C()Lchat/ola/vn/lock/d;

    move-result-object v0

    if-nez v0, :cond_0

    invoke-super {p0}, Lchat/ola/vn/c;->onBackPressed()V

    :cond_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f09039c

    if-eq p1, v0, :cond_1

    const v0, 0x7f09039e

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->f:Lchat/ola/vn/lock/d;

    invoke-virtual {p1}, Lchat/ola/vn/lock/d;->e()V

    return-void

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->onBackPressed()V

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 3

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b0163

    invoke-virtual {p0, p1}, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->setContentView(I)V

    const p1, 0x7f0903a3

    invoke-virtual {p0, p1}, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->g:Landroid/widget/TextView;

    const p1, 0x7f09039c

    invoke-virtual {p0, p1}, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->h:Landroid/widget/TextView;

    iget-object p1, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->h:Landroid/widget/TextView;

    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f09039e

    invoke-virtual {p0, p1}, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->i:Landroid/widget/TextView;

    iget-object p1, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->i:Landroid/widget/TextView;

    const v0, 0x7f0f044d

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(I)V

    iget-object p1, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->i:Landroid/widget/TextView;

    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->i:Landroid/widget/TextView;

    const/4 v0, 0x4

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->h:Landroid/widget/TextView;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    :try_start_0
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/e;->v()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/entity/r;->a(Ljava/lang/String;)Lchat/ola/vn/entity/r;

    move-result-object p1

    sput-object p1, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->e:Lchat/ola/vn/entity/r;

    invoke-virtual {p0}, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object p1

    invoke-virtual {p1}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->e:Lchat/ola/vn/entity/r;

    const v1, 0x7f0903a9

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->e:Lchat/ola/vn/entity/r;

    iget-object v0, v0, Lchat/ola/vn/entity/r;->a:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-class v0, Lchat/ola/vn/lock/a;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/lock/d;

    iput-object v0, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->f:Lchat/ola/vn/lock/d;

    iget-object v0, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->f:Lchat/ola/vn/lock/d;

    const-class v2, Lchat/ola/vn/lock/a;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    :goto_0
    invoke-virtual {p1, v1, v0, v2}, Landroid/support/v4/app/FragmentTransaction;->add(ILandroid/support/v4/app/Fragment;Ljava/lang/String;)Landroid/support/v4/app/FragmentTransaction;

    goto :goto_1

    :cond_0
    const-class v0, Lchat/ola/vn/lock/e;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/lock/d;

    iput-object v0, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->f:Lchat/ola/vn/lock/d;

    iget-object v0, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->f:Lchat/ola/vn/lock/d;

    const-class v2, Lchat/ola/vn/lock/e;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->f:Lchat/ola/vn/lock/d;

    invoke-virtual {v0}, Lchat/ola/vn/lock/d;->e_()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->f:Lchat/ola/vn/lock/d;

    invoke-virtual {v1}, Lchat/ola/vn/lock/d;->d()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->f:Lchat/ola/vn/lock/d;

    invoke-virtual {v2}, Lchat/ola/vn/lock/d;->c()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v0, v1, v2}, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p1}, Landroid/support/v4/app/FragmentTransaction;->commit()I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method
