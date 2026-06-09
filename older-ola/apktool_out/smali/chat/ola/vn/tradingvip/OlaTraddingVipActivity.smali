.class public Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;


# static fields
.field public static e:Lchat/ola/vn/entity/ah;


# instance fields
.field private f:Lchat/ola/vn/tradingvip/a;

.field private g:Landroid/widget/TextView;

.field private h:Landroid/view/View;

.field private i:Landroid/view/View;

.field private j:Landroid/widget/ImageView;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->i:Landroid/view/View;

    return-object p0
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->a(Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/entity/ah;)V

    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/entity/ah;)V
    .locals 1

    sput-object p2, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->e:Lchat/ola/vn/entity/ah;

    new-instance p2, Landroid/content/Intent;

    const-class v0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;

    invoke-direct {p2, p0, v0}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "_buddy_id"

    invoke-virtual {p2, v0, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :cond_0
    const/high16 p1, 0x10000000

    invoke-virtual {p2, p1}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    invoke-virtual {p0, p2}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    :try_start_0
    check-cast p0, Landroid/app/Activity;

    const p1, 0x7f010038

    const p2, 0x7f010039

    invoke-virtual {p0, p1, p2}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public B()V
    .locals 4

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->f:Lchat/ola/vn/tradingvip/a;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->f:Lchat/ola/vn/tradingvip/a;

    invoke-virtual {v1}, Lchat/ola/vn/tradingvip/a;->c()Lchat/ola/vn/tradingvip/a;

    move-result-object v1

    if-eqz v1, :cond_0

    const v2, 0x7f01000d

    const v3, 0x7f01000e

    invoke-virtual {v0, v2, v3}, Landroid/support/v4/app/FragmentTransaction;->setCustomAnimations(II)Landroid/support/v4/app/FragmentTransaction;

    const v2, 0x7f0904d6

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v1, v3}, Landroid/support/v4/app/FragmentTransaction;->replace(ILandroid/support/v4/app/Fragment;Ljava/lang/String;)Landroid/support/v4/app/FragmentTransaction;

    iget-object v2, p0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->f:Lchat/ola/vn/tradingvip/a;

    invoke-virtual {v1, v2}, Lchat/ola/vn/tradingvip/a;->a(Lchat/ola/vn/tradingvip/a;)V

    invoke-virtual {v1}, Lchat/ola/vn/tradingvip/a;->e_()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->f(Ljava/lang/String;)V

    iput-object v1, p0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->f:Lchat/ola/vn/tradingvip/a;

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

.method public C()Lchat/ola/vn/tradingvip/a;
    .locals 4

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->f:Lchat/ola/vn/tradingvip/a;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->f:Lchat/ola/vn/tradingvip/a;

    invoke-virtual {v1}, Lchat/ola/vn/tradingvip/a;->d()Lchat/ola/vn/tradingvip/a;

    move-result-object v1

    if-eqz v1, :cond_0

    const v2, 0x7f01000a

    const v3, 0x7f01000c

    invoke-virtual {v0, v2, v3}, Landroid/support/v4/app/FragmentTransaction;->setCustomAnimations(II)Landroid/support/v4/app/FragmentTransaction;

    const v2, 0x7f0904d6

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v1, v3}, Landroid/support/v4/app/FragmentTransaction;->replace(ILandroid/support/v4/app/Fragment;Ljava/lang/String;)Landroid/support/v4/app/FragmentTransaction;

    invoke-virtual {v1}, Lchat/ola/vn/tradingvip/a;->e_()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->f(Ljava/lang/String;)V

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentTransaction;->commit()I

    :cond_0
    iput-object v1, p0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->f:Lchat/ola/vn/tradingvip/a;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->f:Lchat/ola/vn/tradingvip/a;

    return-object v0
.end method

.method protected a()V
    .locals 0

    return-void
.end method

.method public a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    .locals 0

    const/4 p3, 0x0

    :try_start_0
    invoke-virtual {p0, p3}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->c(Z)V

    const p3, 0x7f0f009f

    packed-switch p1, :pswitch_data_0

    :pswitch_0
    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    goto :goto_1

    :pswitch_1
    const p1, 0x7f0f0262

    :goto_0
    invoke-static {p0, p3, p1}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    return-void

    :pswitch_2
    const p1, 0x7f0f02dc

    goto :goto_0

    :goto_1
    if-nez p1, :cond_0

    invoke-virtual {p0, p3}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->getString(I)Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1, p2}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    return-void

    :cond_0
    const p1, 0x7f0f0263

    invoke-static {p0, p1}, Lchat/ola/vn/util/j;->c(Landroid/content/Context;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x7
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_2
    .end packed-switch
.end method

.method public c(Z)V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->i:Landroid/view/View;

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    const/16 p1, 0x8

    :goto_0
    invoke-virtual {v0, p1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->i:Landroid/view/View;

    new-instance v0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity$1;-><init>(Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;)V

    const-wide/32 v1, 0xea60

    invoke-virtual {p1, v0, v1, v2}, Landroid/view/View;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

.method public f(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->g:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onBackPressed()V
    .locals 1

    invoke-virtual {p0}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->C()Lchat/ola/vn/tradingvip/a;

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

    const v0, 0x7f0903a1

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->finish()V

    return-void

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->onBackPressed()V

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 3

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b0175

    invoke-virtual {p0, p1}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->setContentView(I)V

    const p1, 0x7f0904d7

    invoke-virtual {p0, p1}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->i:Landroid/view/View;

    const p1, 0x7f0903a3

    invoke-virtual {p0, p1}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->g:Landroid/widget/TextView;

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object p1

    invoke-virtual {p1}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->e:Lchat/ola/vn/entity/ah;

    const v1, 0x7f0904d6

    if-nez v0, :cond_0

    const-class v0, Lchat/ola/vn/tradingvip/b;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/tradingvip/a;

    iput-object v0, p0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->f:Lchat/ola/vn/tradingvip/a;

    iget-object v0, p0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->f:Lchat/ola/vn/tradingvip/a;

    const-class v2, Lchat/ola/vn/tradingvip/b;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    :goto_0
    invoke-virtual {p1, v1, v0, v2}, Landroid/support/v4/app/FragmentTransaction;->add(ILandroid/support/v4/app/Fragment;Ljava/lang/String;)Landroid/support/v4/app/FragmentTransaction;

    goto :goto_1

    :cond_0
    const-class v0, Lchat/ola/vn/tradingvip/c;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/tradingvip/a;

    iput-object v0, p0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->f:Lchat/ola/vn/tradingvip/a;

    iget-object v0, p0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->f:Lchat/ola/vn/tradingvip/a;

    const-class v2, Lchat/ola/vn/tradingvip/c;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->f:Lchat/ola/vn/tradingvip/a;

    invoke-virtual {v0}, Lchat/ola/vn/tradingvip/a;->e_()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->f(Ljava/lang/String;)V

    const v0, 0x7f09039c

    invoke-virtual {p0, v0}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->h:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->h:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0903a1

    invoke-virtual {p0, v0}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->j:Landroid/widget/ImageView;

    iget-object v0, p0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->j:Landroid/widget/ImageView;

    const v1, 0x7f080640

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v0, p0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->j:Landroid/widget/ImageView;

    invoke-virtual {v0, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->j:Landroid/widget/ImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->h:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    invoke-virtual {p1}, Landroid/support/v4/app/FragmentTransaction;->commit()I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method
