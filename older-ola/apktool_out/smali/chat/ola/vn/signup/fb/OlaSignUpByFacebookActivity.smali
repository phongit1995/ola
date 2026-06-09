.class public Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;


# static fields
.field private static e:Z = false


# instance fields
.field private f:Lchat/ola/vn/signup/fb/b;

.field private g:Landroid/widget/TextView;

.field private h:Landroid/widget/TextView;

.field private i:Landroid/view/View;

.field private j:Ljava/lang/Runnable;

.field private k:Landroid/widget/TextView;


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

.method static synthetic a(Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->i:Landroid/view/View;

    return-object p0
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/util/List;)Z

    move-result p0

    return p0
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;Ljava/util/List;)Z
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)Z"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    sget-boolean v1, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->e:Z

    if-nez v1, :cond_3

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    return v0

    :cond_0
    new-instance v1, Landroid/content/Intent;

    const-class v2, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    invoke-direct {v1, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v2, "_trust_token"

    invoke-virtual {v1, v2, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-eqz p2, :cond_2

    :try_start_1
    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result p1

    new-array p1, p1, [Ljava/lang/String;

    const/4 v2, 0x0

    :goto_0
    array-length v3, p1

    if-ge v2, v3, :cond_1

    new-instance v3, Ljava/lang/String;

    invoke-interface {p2, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-direct {v3, v4}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    aput-object v3, p1, v2

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    const-string p2, "_byte_data"

    invoke-virtual {v1, p2, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;[Ljava/lang/String;)Landroid/content/Intent;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_2
    :try_start_2
    invoke-virtual {p0, v1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    const/4 p0, 0x1

    return p0

    :catch_1
    :cond_3
    return v0
.end method


# virtual methods
.method public B()V
    .locals 4

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->f:Lchat/ola/vn/signup/fb/b;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->f:Lchat/ola/vn/signup/fb/b;

    invoke-virtual {v1}, Lchat/ola/vn/signup/fb/b;->c()Lchat/ola/vn/signup/fb/b;

    move-result-object v1

    if-eqz v1, :cond_1

    const v2, 0x7f01000d

    const v3, 0x7f01000e

    invoke-virtual {v0, v2, v3}, Landroid/support/v4/app/FragmentTransaction;->setCustomAnimations(II)Landroid/support/v4/app/FragmentTransaction;

    const v2, 0x7f090475

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v1, v3}, Landroid/support/v4/app/FragmentTransaction;->replace(ILandroid/support/v4/app/Fragment;Ljava/lang/String;)Landroid/support/v4/app/FragmentTransaction;

    iget-object v2, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->f:Lchat/ola/vn/signup/fb/b;

    invoke-virtual {v1, v2}, Lchat/ola/vn/signup/fb/b;->a(Lchat/ola/vn/signup/fb/b;)V

    invoke-virtual {v1}, Lchat/ola/vn/signup/fb/b;->e_()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1}, Lchat/ola/vn/signup/fb/b;->h()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v2, v3}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->f(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v2, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->h:Landroid/widget/TextView;

    invoke-virtual {v1}, Lchat/ola/vn/signup/fb/b;->d()Lchat/ola/vn/signup/fb/b;

    move-result-object v3

    if-eqz v3, :cond_0

    const/4 v3, 0x0

    goto :goto_0

    :cond_0
    const/4 v3, 0x4

    :goto_0
    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iput-object v1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->f:Lchat/ola/vn/signup/fb/b;

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

.method public C()Lchat/ola/vn/signup/fb/b;
    .locals 4

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->f:Lchat/ola/vn/signup/fb/b;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->f:Lchat/ola/vn/signup/fb/b;

    invoke-virtual {v1}, Lchat/ola/vn/signup/fb/b;->d()Lchat/ola/vn/signup/fb/b;

    move-result-object v1

    if-eqz v1, :cond_1

    const v2, 0x7f01000a

    const v3, 0x7f01000c

    invoke-virtual {v0, v2, v3}, Landroid/support/v4/app/FragmentTransaction;->setCustomAnimations(II)Landroid/support/v4/app/FragmentTransaction;

    const v2, 0x7f090475

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v1, v3}, Landroid/support/v4/app/FragmentTransaction;->replace(ILandroid/support/v4/app/Fragment;Ljava/lang/String;)Landroid/support/v4/app/FragmentTransaction;

    invoke-virtual {v1}, Lchat/ola/vn/signup/fb/b;->e_()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1}, Lchat/ola/vn/signup/fb/b;->h()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v2, v3}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->f(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v2, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->h:Landroid/widget/TextView;

    invoke-virtual {v1}, Lchat/ola/vn/signup/fb/b;->d()Lchat/ola/vn/signup/fb/b;

    move-result-object v3

    if-eqz v3, :cond_0

    const/4 v3, 0x0

    goto :goto_0

    :cond_0
    const/4 v3, 0x4

    :goto_0
    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setVisibility(I)V

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentTransaction;->commit()I

    :cond_1
    iput-object v1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->f:Lchat/ola/vn/signup/fb/b;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_2
    :goto_1
    iget-object v0, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->f:Lchat/ola/vn/signup/fb/b;

    return-object v0
.end method

.method protected a()V
    .locals 0

    return-void
.end method

.method protected b()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public c(Z)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->j:Ljava/lang/Runnable;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity$1;-><init>(Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;)V

    iput-object v0, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->j:Ljava/lang/Runnable;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->j:Ljava/lang/Runnable;

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->j:Ljava/lang/Runnable;

    const-wide/32 v0, 0xea60

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->i:Landroid/view/View;

    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->i:Landroid/view/View;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/16 v0, 0x8

    goto :goto_0

    :catch_0
    return-void
.end method

.method public f(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->g:Landroid/widget/TextView;

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
    .locals 1

    invoke-virtual {p0, p1}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->f(Ljava/lang/String;)V

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->k:Landroid/widget/TextView;

    const/4 p2, 0x4

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setVisibility(I)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->k:Landroid/widget/TextView;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->k:Landroid/widget/TextView;

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public onBackPressed()V
    .locals 1

    invoke-virtual {p0}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->C()Lchat/ola/vn/signup/fb/b;

    move-result-object v0

    if-nez v0, :cond_0

    invoke-super {p0}, Lchat/ola/vn/c;->onBackPressed()V

    :cond_0
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
    iget-object p1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->f:Lchat/ola/vn/signup/fb/b;

    invoke-virtual {p1}, Lchat/ola/vn/signup/fb/b;->j()V

    return-void

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->C()Lchat/ola/vn/signup/fb/b;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 6

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const/4 p1, 0x1

    sput-boolean p1, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->e:Z

    const p1, 0x7f0b016f

    invoke-virtual {p0, p1}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->setContentView(I)V

    const p1, 0x7f0903a3

    invoke-virtual {p0, p1}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->g:Landroid/widget/TextView;

    const p1, 0x7f09030f

    invoke-virtual {p0, p1}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->i:Landroid/view/View;

    const p1, 0x7f09039c

    invoke-virtual {p0, p1}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->h:Landroid/widget/TextView;

    iget-object p1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->h:Landroid/widget/TextView;

    const v0, 0x7f0f042c

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->h:Landroid/widget/TextView;

    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f09039e

    invoke-virtual {p0, p1}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->k:Landroid/widget/TextView;

    iget-object p1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->k:Landroid/widget/TextView;

    const/4 v0, 0x4

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->k:Landroid/widget/TextView;

    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    const-string v1, "_trust_token"

    invoke-virtual {p1, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->getIntent()Landroid/content/Intent;

    move-result-object v1

    const-string v2, "_byte_data"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->getStringArrayExtra(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v2

    invoke-virtual {v2}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object v2

    const v3, 0x7f090475

    if-eqz v1, :cond_0

    array-length v4, v1

    if-lez v4, :cond_0

    const-class v4, Lchat/ola/vn/signup/fb/a;

    invoke-virtual {v4}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v4

    invoke-static {p0, v4}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/signup/fb/b;

    iput-object v4, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->f:Lchat/ola/vn/signup/fb/b;

    new-instance v4, Landroid/os/Bundle;

    invoke-direct {v4}, Landroid/os/Bundle;-><init>()V

    const-string v5, "_trust_token"

    invoke-virtual {v4, v5, p1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "_byte_data"

    invoke-virtual {v4, p1, v1}, Landroid/os/Bundle;->putStringArray(Ljava/lang/String;[Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->f:Lchat/ola/vn/signup/fb/b;

    invoke-virtual {p1, v4}, Lchat/ola/vn/signup/fb/b;->setArguments(Landroid/os/Bundle;)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->f:Lchat/ola/vn/signup/fb/b;

    const-class v1, Lchat/ola/vn/signup/fb/a;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    :goto_0
    invoke-virtual {v2, v3, p1, v1}, Landroid/support/v4/app/FragmentTransaction;->add(ILandroid/support/v4/app/Fragment;Ljava/lang/String;)Landroid/support/v4/app/FragmentTransaction;

    goto :goto_1

    :cond_0
    sput-object p1, Lchat/ola/vn/signup/fb/d;->a:Ljava/lang/String;

    sget-object p1, Lchat/ola/vn/h;->S:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_1

    const/4 p1, 0x0

    sput-object p1, Lchat/ola/vn/signup/fb/d;->c:Ljava/lang/String;

    const-class p1, Lchat/ola/vn/signup/fb/c;

    invoke-virtual {p1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/signup/fb/b;

    iput-object p1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->f:Lchat/ola/vn/signup/fb/b;

    iget-object p1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->f:Lchat/ola/vn/signup/fb/b;

    const-class v1, Lchat/ola/vn/signup/fb/c;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_1
    sget-object p1, Lchat/ola/vn/h;->S:Ljava/lang/String;

    sput-object p1, Lchat/ola/vn/signup/fb/d;->c:Ljava/lang/String;

    const-class p1, Lchat/ola/vn/signup/fb/d;

    invoke-virtual {p1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/signup/fb/b;

    iput-object p1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->f:Lchat/ola/vn/signup/fb/b;

    iget-object p1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->f:Lchat/ola/vn/signup/fb/b;

    const-class v1, Lchat/ola/vn/signup/fb/d;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->f:Lchat/ola/vn/signup/fb/b;

    invoke-virtual {p1}, Lchat/ola/vn/signup/fb/b;->e_()Ljava/lang/String;

    move-result-object p1

    iget-object v1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->f:Lchat/ola/vn/signup/fb/b;

    invoke-virtual {v1}, Lchat/ola/vn/signup/fb/b;->h()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, p1, v1}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->f(Ljava/lang/String;Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->h:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->f:Lchat/ola/vn/signup/fb/b;

    invoke-virtual {v1}, Lchat/ola/vn/signup/fb/b;->d()Lchat/ola/vn/signup/fb/b;

    move-result-object v1

    if-eqz v1, :cond_2

    const/4 v0, 0x0

    :cond_2
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    invoke-virtual {v2}, Landroid/support/v4/app/FragmentTransaction;->commit()I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method protected onDestroy()V
    .locals 1

    const/4 v0, 0x0

    sput-boolean v0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->e:Z

    invoke-super {p0}, Lchat/ola/vn/c;->onDestroy()V

    return-void
.end method
