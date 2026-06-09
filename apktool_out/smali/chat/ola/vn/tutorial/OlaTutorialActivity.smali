.class public Lchat/ola/vn/tutorial/OlaTutorialActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;


# static fields
.field public static e:Z = false

.field public static f:Z = false

.field static g:B


# instance fields
.field private h:Lchat/ola/vn/tutorial/c;

.field private i:Landroid/widget/TextView;

.field private j:Landroid/widget/TextView;

.field private k:Landroid/widget/TextView;

.field private l:Landroid/view/View;

.field private m:Ljava/lang/Runnable;


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

.method static synthetic a(Lchat/ola/vn/tutorial/OlaTutorialActivity;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->l:Landroid/view/View;

    return-object p0
.end method

.method public static a(Landroid/content/Context;)V
    .locals 2

    const/4 v0, 0x0

    sput-byte v0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->g:B

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/tutorial/OlaTutorialActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 v1, 0x10000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    return-void
.end method


# virtual methods
.method public B()V
    .locals 4

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/tutorial/OlaTutorialActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->h:Lchat/ola/vn/tutorial/c;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->h:Lchat/ola/vn/tutorial/c;

    invoke-virtual {v1}, Lchat/ola/vn/tutorial/c;->c()Lchat/ola/vn/tutorial/c;

    move-result-object v1

    if-eqz v1, :cond_2

    const v2, 0x7f01000d

    const v3, 0x7f01000e

    invoke-virtual {v0, v2, v3}, Landroid/support/v4/app/FragmentTransaction;->setCustomAnimations(II)Landroid/support/v4/app/FragmentTransaction;

    const v2, 0x7f0904e2

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v1, v3}, Landroid/support/v4/app/FragmentTransaction;->replace(ILandroid/support/v4/app/Fragment;Ljava/lang/String;)Landroid/support/v4/app/FragmentTransaction;

    iget-object v2, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->h:Lchat/ola/vn/tutorial/c;

    invoke-virtual {v1, v2}, Lchat/ola/vn/tutorial/c;->a(Lchat/ola/vn/tutorial/c;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    iget-object v2, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->h:Lchat/ola/vn/tutorial/c;

    instance-of v2, v2, Lchat/ola/vn/tutorial/a;

    if-eqz v2, :cond_0

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Lchat/ola/vn/tutorial/c;->a(Lchat/ola/vn/tutorial/c;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_0
    :try_start_2
    invoke-virtual {v1}, Lchat/ola/vn/tutorial/c;->e_()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1}, Lchat/ola/vn/tutorial/c;->d()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v2, v3}, Lchat/ola/vn/tutorial/OlaTutorialActivity;->f(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v2, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->j:Landroid/widget/TextView;

    invoke-virtual {v1}, Lchat/ola/vn/tutorial/c;->h()Lchat/ola/vn/tutorial/c;

    move-result-object v3

    if-eqz v3, :cond_1

    const/4 v3, 0x0

    goto :goto_0

    :cond_1
    const/4 v3, 0x4

    :goto_0
    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iput-object v1, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->h:Lchat/ola/vn/tutorial/c;

    :cond_2
    invoke-virtual {v0}, Landroid/support/v4/app/FragmentTransaction;->commit()I
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return-void

    :catch_1
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public C()V
    .locals 4

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/tutorial/OlaTutorialActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->h:Lchat/ola/vn/tutorial/c;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->h:Lchat/ola/vn/tutorial/c;

    invoke-virtual {v1}, Lchat/ola/vn/tutorial/c;->h()Lchat/ola/vn/tutorial/c;

    move-result-object v1

    if-eqz v1, :cond_1

    const v2, 0x7f01000a

    const v3, 0x7f01000c

    invoke-virtual {v0, v2, v3}, Landroid/support/v4/app/FragmentTransaction;->setCustomAnimations(II)Landroid/support/v4/app/FragmentTransaction;

    const v2, 0x7f0904e2

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v1, v3}, Landroid/support/v4/app/FragmentTransaction;->replace(ILandroid/support/v4/app/Fragment;Ljava/lang/String;)Landroid/support/v4/app/FragmentTransaction;

    invoke-virtual {v1}, Lchat/ola/vn/tutorial/c;->e_()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1}, Lchat/ola/vn/tutorial/c;->d()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v2, v3}, Lchat/ola/vn/tutorial/OlaTutorialActivity;->f(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v2, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->j:Landroid/widget/TextView;

    invoke-virtual {v1}, Lchat/ola/vn/tutorial/c;->h()Lchat/ola/vn/tutorial/c;

    move-result-object v3

    if-eqz v3, :cond_0

    const/4 v3, 0x0

    goto :goto_0

    :cond_0
    const/4 v3, 0x4

    :goto_0
    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iput-object v1, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->h:Lchat/ola/vn/tutorial/c;

    :cond_1
    invoke-virtual {v0}, Landroid/support/v4/app/FragmentTransaction;->commit()I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method protected a()V
    .locals 0

    return-void
.end method

.method public c(Z)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->m:Ljava/lang/Runnable;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/tutorial/OlaTutorialActivity$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/tutorial/OlaTutorialActivity$1;-><init>(Lchat/ola/vn/tutorial/OlaTutorialActivity;)V

    iput-object v0, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->m:Ljava/lang/Runnable;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->m:Ljava/lang/Runnable;

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->m:Ljava/lang/Runnable;

    const-wide/32 v0, 0xea60

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    iget-object p1, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->l:Landroid/view/View;

    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->l:Landroid/view/View;

    const/16 v0, 0x8

    goto :goto_0

    return-void
.end method

.method public f(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->i:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public f(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/tutorial/OlaTutorialActivity;->f(Ljava/lang/String;)V

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->k:Landroid/widget/TextView;

    const/4 p2, 0x4

    :goto_0
    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setVisibility(I)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->k:Landroid/widget/TextView;

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->k:Landroid/widget/TextView;

    const/4 p2, 0x0

    goto :goto_0

    return-void
.end method

.method public onBackPressed()V
    .locals 0

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/tutorial/OlaTutorialActivity;->C()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f09039c

    if-eq p1, v0, :cond_1

    const v0, 0x7f09039e

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->h:Lchat/ola/vn/tutorial/c;

    invoke-virtual {p1}, Lchat/ola/vn/tutorial/c;->e()V

    return-void

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/tutorial/OlaTutorialActivity;->C()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 3

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b0021

    invoke-virtual {p0, p1}, Lchat/ola/vn/tutorial/OlaTutorialActivity;->setContentView(I)V

    const p1, 0x7f09030f

    invoke-virtual {p0, p1}, Lchat/ola/vn/tutorial/OlaTutorialActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->l:Landroid/view/View;

    const p1, 0x7f0903a3

    invoke-virtual {p0, p1}, Lchat/ola/vn/tutorial/OlaTutorialActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->i:Landroid/widget/TextView;

    const p1, 0x7f09039c

    invoke-virtual {p0, p1}, Lchat/ola/vn/tutorial/OlaTutorialActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->j:Landroid/widget/TextView;

    iget-object p1, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->j:Landroid/widget/TextView;

    const v0, 0x7f0f042c

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(I)V

    iget-object p1, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->j:Landroid/widget/TextView;

    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f09039e

    invoke-virtual {p0, p1}, Lchat/ola/vn/tutorial/OlaTutorialActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->k:Landroid/widget/TextView;

    iget-object p1, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->k:Landroid/widget/TextView;

    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :try_start_0
    sget-boolean p1, Lchat/ola/vn/tutorial/OlaTutorialActivity;->f:Z

    if-eqz p1, :cond_0

    invoke-static {}, Lchat/ola/vn/v/e;->a()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    :try_start_1
    invoke-virtual {p0}, Lchat/ola/vn/tutorial/OlaTutorialActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object p1

    invoke-virtual {p1}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object p1

    sget-boolean v0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->e:Z

    const v1, 0x7f0904e2

    if-eqz v0, :cond_1

    const-class v0, Lchat/ola/vn/tutorial/a;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/tutorial/c;

    iput-object v0, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->h:Lchat/ola/vn/tutorial/c;

    iget-object v0, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->h:Lchat/ola/vn/tutorial/c;

    const-class v2, Lchat/ola/vn/tutorial/a;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    :goto_0
    invoke-virtual {p1, v1, v0, v2}, Landroid/support/v4/app/FragmentTransaction;->add(ILandroid/support/v4/app/Fragment;Ljava/lang/String;)Landroid/support/v4/app/FragmentTransaction;

    goto :goto_1

    :cond_1
    sget-boolean v0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->f:Z

    if-eqz v0, :cond_2

    const/4 v0, 0x1

    sput-byte v0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->g:B

    :cond_2
    sget-byte v0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->g:B

    if-eqz v0, :cond_3

    const-class v0, Lchat/ola/vn/tutorial/b;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/tutorial/c;

    iput-object v0, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->h:Lchat/ola/vn/tutorial/c;

    iget-object v0, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->h:Lchat/ola/vn/tutorial/c;

    const-class v2, Lchat/ola/vn/tutorial/b;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :cond_3
    const-class v0, Lchat/ola/vn/tutorial/d;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/tutorial/c;

    iput-object v0, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->h:Lchat/ola/vn/tutorial/c;

    iget-object v0, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->h:Lchat/ola/vn/tutorial/c;

    const-class v2, Lchat/ola/vn/tutorial/d;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->h:Lchat/ola/vn/tutorial/c;

    invoke-virtual {v0}, Lchat/ola/vn/tutorial/c;->e_()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->h:Lchat/ola/vn/tutorial/c;

    invoke-virtual {v1}, Lchat/ola/vn/tutorial/c;->d()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/tutorial/OlaTutorialActivity;->f(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->j:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->h:Lchat/ola/vn/tutorial/c;

    invoke-virtual {v1}, Lchat/ola/vn/tutorial/c;->h()Lchat/ola/vn/tutorial/c;

    move-result-object v1

    if-eqz v1, :cond_4

    const/4 v1, 0x0

    goto :goto_2

    :cond_4
    const/4 v1, 0x4

    :goto_2
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    invoke-virtual {p1}, Landroid/support/v4/app/FragmentTransaction;->commit()I
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :catch_1
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method
