.class public Lchat/ola/vn/transferken/OlaTransferKenActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private e:Lchat/ola/vn/transferken/a;

.field private f:Landroid/widget/TextView;

.field private g:Landroid/view/View;

.field private h:Landroid/view/View;

.field private i:Landroid/widget/ImageView;

.field private j:Ljava/lang/Runnable;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/transferken/OlaTransferKenActivity;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/transferken/OlaTransferKenActivity;->h:Landroid/view/View;

    return-object p0
.end method

.method public static a(Landroid/content/Context;)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/transferken/OlaTransferKenActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 v1, 0x10000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

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

.method public static a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/transferken/OlaTransferKenActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "_buddy_id"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :cond_0
    const/high16 p1, 0x10000000

    invoke-virtual {v0, p1}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    :try_start_0
    check-cast p0, Landroid/app/Activity;

    const p1, 0x7f010038

    const v0, 0x7f010039

    invoke-virtual {p0, p1, v0}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public B()V
    .locals 4

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/transferken/OlaTransferKenActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/transferken/OlaTransferKenActivity;->e:Lchat/ola/vn/transferken/a;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/transferken/OlaTransferKenActivity;->e:Lchat/ola/vn/transferken/a;

    invoke-virtual {v1}, Lchat/ola/vn/transferken/a;->c()Lchat/ola/vn/transferken/a;

    move-result-object v1

    if-eqz v1, :cond_0

    const v2, 0x7f01000d

    const v3, 0x7f01000e

    invoke-virtual {v0, v2, v3}, Landroid/support/v4/app/FragmentTransaction;->setCustomAnimations(II)Landroid/support/v4/app/FragmentTransaction;

    const v2, 0x7f0904db

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v1, v3}, Landroid/support/v4/app/FragmentTransaction;->replace(ILandroid/support/v4/app/Fragment;Ljava/lang/String;)Landroid/support/v4/app/FragmentTransaction;

    iget-object v2, p0, Lchat/ola/vn/transferken/OlaTransferKenActivity;->e:Lchat/ola/vn/transferken/a;

    invoke-virtual {v1, v2}, Lchat/ola/vn/transferken/a;->a(Lchat/ola/vn/transferken/a;)V

    invoke-virtual {v1}, Lchat/ola/vn/transferken/a;->e_()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lchat/ola/vn/transferken/OlaTransferKenActivity;->f(Ljava/lang/String;)V

    iput-object v1, p0, Lchat/ola/vn/transferken/OlaTransferKenActivity;->e:Lchat/ola/vn/transferken/a;

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

.method public C()Lchat/ola/vn/transferken/a;
    .locals 4

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/transferken/OlaTransferKenActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/transferken/OlaTransferKenActivity;->e:Lchat/ola/vn/transferken/a;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/transferken/OlaTransferKenActivity;->e:Lchat/ola/vn/transferken/a;

    invoke-virtual {v1}, Lchat/ola/vn/transferken/a;->d()Lchat/ola/vn/transferken/a;

    move-result-object v1

    if-eqz v1, :cond_0

    const v2, 0x7f01000a

    const v3, 0x7f01000c

    invoke-virtual {v0, v2, v3}, Landroid/support/v4/app/FragmentTransaction;->setCustomAnimations(II)Landroid/support/v4/app/FragmentTransaction;

    const v2, 0x7f0904db

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v1, v3}, Landroid/support/v4/app/FragmentTransaction;->replace(ILandroid/support/v4/app/Fragment;Ljava/lang/String;)Landroid/support/v4/app/FragmentTransaction;

    invoke-virtual {v1}, Lchat/ola/vn/transferken/a;->e_()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lchat/ola/vn/transferken/OlaTransferKenActivity;->f(Ljava/lang/String;)V

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentTransaction;->commit()I

    :cond_0
    iput-object v1, p0, Lchat/ola/vn/transferken/OlaTransferKenActivity;->e:Lchat/ola/vn/transferken/a;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/transferken/OlaTransferKenActivity;->e:Lchat/ola/vn/transferken/a;

    return-object v0
.end method

.method protected a()V
    .locals 0

    return-void
.end method

.method public a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    .locals 0

    const/4 p2, 0x0

    invoke-virtual {p0, p2}, Lchat/ola/vn/transferken/OlaTransferKenActivity;->c(Z)V

    const/16 p2, 0xa

    const p3, 0x7f0f009f

    if-eq p1, p2, :cond_1

    const/16 p2, 0x27

    if-eq p1, p2, :cond_0

    packed-switch p1, :pswitch_data_0

    return-void

    :pswitch_0
    const p1, 0x7f0f0262

    goto :goto_0

    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p1

    sput-wide p1, Lchat/ola/vn/transferken/c;->a:J

    return-void

    :cond_1
    :pswitch_1
    const p1, 0x7f0f02dc

    :goto_0
    invoke-static {p0, p3, p1}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x7
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public a(S)V
    .locals 5

    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Lchat/ola/vn/transferken/OlaTransferKenActivity;->c(Z)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    sput-wide v0, Lchat/ola/vn/transferken/c;->a:J

    sget-object v0, Lchat/ola/vn/transferken/c;->c:Lchat/ola/vn/entity/ag;

    iget-object v0, v0, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    const/4 v1, 0x1

    :try_start_0
    sget-object v2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v2, v0, p1}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v2

    if-nez v2, :cond_0

    sget-object v2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v2, v0, p1, v1}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;SZ)Lchat/ola/vn/message/f;

    move-result-object v2

    :cond_0
    if-eqz v2, :cond_1

    sget-wide v3, Lchat/ola/vn/transferken/c;->b:J

    invoke-static {v0, v3, v4}, Lchat/ola/vn/message/e;->b(Ljava/lang/String;J)Lchat/ola/vn/message/j;

    move-result-object v3

    const/4 v4, 0x2

    invoke-virtual {v3, v4}, Lchat/ola/vn/message/j;->a(B)V

    invoke-virtual {v2, v3}, Lchat/ola/vn/message/f;->a(Lchat/ola/vn/message/d;)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    iput-object v3, v2, Lchat/ola/vn/message/f;->K:Ljava/lang/Long;

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2, v0}, Lchat/ola/vn/util/c/b;->c(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    invoke-static {p0, v0}, Lchat/ola/vn/util/c/b;->c(Landroid/content/Context;Ljava/lang/String;)V

    const v2, 0x7f0f00a2

    invoke-virtual {p0, v2}, Lchat/ola/vn/transferken/OlaTransferKenActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    const v3, 0x7f0f0374

    new-array v1, v1, [Ljava/lang/Object;

    aput-object v0, v1, p1

    invoke-virtual {p0, v3, v1}, Lchat/ola/vn/transferken/OlaTransferKenActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, v2, p1}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    move-result-object p1

    new-instance v0, Lchat/ola/vn/transferken/OlaTransferKenActivity$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/transferken/OlaTransferKenActivity$1;-><init>(Lchat/ola/vn/transferken/OlaTransferKenActivity;)V

    invoke-virtual {p1, v0}, Landroid/app/Dialog;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)V

    return-void
.end method

.method public c(Z)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/transferken/OlaTransferKenActivity;->h:Landroid/view/View;

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    const/16 p1, 0x8

    :goto_0
    invoke-virtual {v0, p1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/transferken/OlaTransferKenActivity;->j:Ljava/lang/Runnable;

    if-nez p1, :cond_1

    new-instance p1, Lchat/ola/vn/transferken/OlaTransferKenActivity$2;

    invoke-direct {p1, p0}, Lchat/ola/vn/transferken/OlaTransferKenActivity$2;-><init>(Lchat/ola/vn/transferken/OlaTransferKenActivity;)V

    iput-object p1, p0, Lchat/ola/vn/transferken/OlaTransferKenActivity;->j:Ljava/lang/Runnable;

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/transferken/OlaTransferKenActivity;->j:Ljava/lang/Runnable;

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V

    iget-object p1, p0, Lchat/ola/vn/transferken/OlaTransferKenActivity;->j:Ljava/lang/Runnable;

    const-wide/32 v0, 0xea60

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public f(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/transferken/OlaTransferKenActivity;->f:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/transferken/OlaTransferKenActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onBackPressed()V
    .locals 1

    invoke-virtual {p0}, Lchat/ola/vn/transferken/OlaTransferKenActivity;->C()Lchat/ola/vn/transferken/a;

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
    invoke-virtual {p0}, Lchat/ola/vn/transferken/OlaTransferKenActivity;->finish()V

    return-void

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/transferken/OlaTransferKenActivity;->onBackPressed()V

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 3

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b0179

    invoke-virtual {p0, p1}, Lchat/ola/vn/transferken/OlaTransferKenActivity;->setContentView(I)V

    const p1, 0x7f0904dd

    invoke-virtual {p0, p1}, Lchat/ola/vn/transferken/OlaTransferKenActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/transferken/OlaTransferKenActivity;->h:Landroid/view/View;

    const p1, 0x7f0903a3

    invoke-virtual {p0, p1}, Lchat/ola/vn/transferken/OlaTransferKenActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/transferken/OlaTransferKenActivity;->f:Landroid/widget/TextView;

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/transferken/OlaTransferKenActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object p1

    invoke-virtual {p1}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object p1

    const-class v0, Lchat/ola/vn/transferken/b;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/transferken/a;

    iput-object v0, p0, Lchat/ola/vn/transferken/OlaTransferKenActivity;->e:Lchat/ola/vn/transferken/a;

    const v0, 0x7f0904db

    iget-object v1, p0, Lchat/ola/vn/transferken/OlaTransferKenActivity;->e:Lchat/ola/vn/transferken/a;

    const-class v2, Lchat/ola/vn/transferken/b;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1, v0, v1, v2}, Landroid/support/v4/app/FragmentTransaction;->add(ILandroid/support/v4/app/Fragment;Ljava/lang/String;)Landroid/support/v4/app/FragmentTransaction;

    iget-object v0, p0, Lchat/ola/vn/transferken/OlaTransferKenActivity;->e:Lchat/ola/vn/transferken/a;

    invoke-virtual {v0}, Lchat/ola/vn/transferken/a;->e_()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lchat/ola/vn/transferken/OlaTransferKenActivity;->f(Ljava/lang/String;)V

    const v0, 0x7f09039c

    invoke-virtual {p0, v0}, Lchat/ola/vn/transferken/OlaTransferKenActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/transferken/OlaTransferKenActivity;->g:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/transferken/OlaTransferKenActivity;->g:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0903a1

    invoke-virtual {p0, v0}, Lchat/ola/vn/transferken/OlaTransferKenActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lchat/ola/vn/transferken/OlaTransferKenActivity;->i:Landroid/widget/ImageView;

    iget-object v0, p0, Lchat/ola/vn/transferken/OlaTransferKenActivity;->i:Landroid/widget/ImageView;

    const v1, 0x7f080640

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v0, p0, Lchat/ola/vn/transferken/OlaTransferKenActivity;->i:Landroid/widget/ImageView;

    invoke-virtual {v0, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/transferken/OlaTransferKenActivity;->i:Landroid/widget/ImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/transferken/OlaTransferKenActivity;->g:Landroid/view/View;

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
