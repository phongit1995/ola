.class public Lchat/ola/vn/signup/OlaSignUpActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;


# static fields
.field static e:Ljava/lang/String; = null

.field static f:Ljava/lang/String; = null

.field static g:Ljava/lang/String; = null

.field static h:Ljava/lang/String; = null

.field static i:Ljava/lang/String; = null

.field static j:Ljava/lang/Long; = null

.field static k:[B = null

.field static l:B = -0x1t

.field static m:Ljava/lang/String;


# instance fields
.field private n:Lchat/ola/vn/signup/a;

.field private o:Landroid/widget/TextView;

.field private p:Landroid/widget/TextView;

.field private q:Landroid/view/View;

.field private r:Landroid/widget/TextView;

.field private s:Ljava/lang/Runnable;


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

.method private D()Z
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->n:Lchat/ola/vn/signup/a;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->n:Lchat/ola/vn/signup/a;

    invoke-virtual {v0}, Lchat/ola/vn/signup/a;->d()Lchat/ola/vn/signup/a;

    move-result-object v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method static synthetic a(Lchat/ola/vn/signup/OlaSignUpActivity;)Lchat/ola/vn/signup/a;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->n:Lchat/ola/vn/signup/a;

    return-object p0
.end method

.method public static a(Landroid/content/Context;)Ljava/util/List;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    const/16 v0, 0x40

    const/4 v1, 0x0

    const/4 v2, 0x0

    :try_start_0
    invoke-static {p0}, Landroid/accounts/AccountManager;->get(Landroid/content/Context;)Landroid/accounts/AccountManager;

    move-result-object v3

    sget v4, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v5, 0x17

    if-lt v4, v5, :cond_4

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v4

    const-string v5, "android.permission.GET_ACCOUNTS"

    invoke-virtual {v4, v5}, Lchat/ola/vn/c;->checkSelfPermission(Ljava/lang/String;)I

    move-result v4

    if-nez v4, :cond_4

    const-string v4, "com.google"

    invoke-virtual {v3, v4}, Landroid/accounts/AccountManager;->getAccountsByType(Ljava/lang/String;)[Landroid/accounts/Account;

    move-result-object v3

    array-length v4, v3
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    move-object v5, v2

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v4, :cond_3

    :try_start_1
    aget-object v6, v3, v2

    iget-object v6, v6, Landroid/accounts/Account;->name:Ljava/lang/String;

    invoke-static {v6}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v7

    if-nez v7, :cond_2

    invoke-virtual {v6, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v7

    if-lez v7, :cond_0

    invoke-virtual {v6, v1, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v6

    :cond_0
    invoke-static {v6}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v7

    if-nez v7, :cond_2

    if-nez v5, :cond_1

    new-instance v7, Ljava/util/ArrayList;

    invoke-direct {v7}, Ljava/util/ArrayList;-><init>()V

    move-object v5, v7

    :cond_1
    invoke-interface {v5, v6}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_2

    invoke-interface {v5, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :cond_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :catch_0
    :cond_3
    move-object v2, v5

    :catch_1
    :cond_4
    :try_start_2
    invoke-static {p0}, Lchat/ola/vn/util/n;->g(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_6

    invoke-static {v3}, Lchat/ola/vn/util/m;->r(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    if-nez v2, :cond_5

    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    move-object v2, v4

    :cond_5
    invoke-interface {v2, v3}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_6

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_6
    invoke-static {p0}, Lchat/ola/vn/util/n;->h(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_9

    invoke-virtual {p0, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-lez v0, :cond_7

    invoke-virtual {p0, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    :cond_7
    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_9

    if-nez v2, :cond_8

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    move-object v2, v0

    :cond_8
    invoke-interface {v2, p0}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_9

    invoke-interface {v2, p0}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    :cond_9
    return-object v2
.end method

.method public static a(Lchat/ola/vn/c;)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, v0}, Lchat/ola/vn/signup/OlaSignUpActivity;->a(Lchat/ola/vn/c;Ljava/lang/String;)V

    return-void
.end method

.method public static a(Lchat/ola/vn/c;Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    sput-object v0, Lchat/ola/vn/signup/OlaSignUpActivity;->k:[B

    sput-object p1, Lchat/ola/vn/signup/OlaSignUpActivity;->m:Ljava/lang/String;

    new-instance p1, Landroid/content/Intent;

    const-class v0, Lchat/ola/vn/signup/OlaSignUpActivity;

    invoke-direct {p1, p0, v0}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/4 v0, 0x1

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/c;->startActivityForResult(Landroid/content/Intent;I)V

    const p1, 0x7f010038

    const v0, 0x7f010039

    :try_start_0
    invoke-virtual {p0, p1, v0}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public B()V
    .locals 5

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/signup/OlaSignUpActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->n:Lchat/ola/vn/signup/a;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->n:Lchat/ola/vn/signup/a;

    invoke-virtual {v1}, Lchat/ola/vn/signup/a;->c()Lchat/ola/vn/signup/a;

    move-result-object v1

    if-eqz v1, :cond_0

    const v2, 0x7f01000d

    const v3, 0x7f01000e

    invoke-virtual {v0, v2, v3}, Landroid/support/v4/app/FragmentTransaction;->setCustomAnimations(II)Landroid/support/v4/app/FragmentTransaction;

    const v2, 0x7f090474

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v1, v3}, Landroid/support/v4/app/FragmentTransaction;->replace(ILandroid/support/v4/app/Fragment;Ljava/lang/String;)Landroid/support/v4/app/FragmentTransaction;

    iget-object v2, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->n:Lchat/ola/vn/signup/a;

    invoke-virtual {v1, v2}, Lchat/ola/vn/signup/a;->a(Lchat/ola/vn/signup/a;)V

    invoke-virtual {v1}, Lchat/ola/vn/signup/a;->e_()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1}, Lchat/ola/vn/signup/a;->e()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1}, Lchat/ola/vn/signup/a;->h()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v2, v3, v4}, Lchat/ola/vn/signup/OlaSignUpActivity;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iput-object v1, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->n:Lchat/ola/vn/signup/a;

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

.method public C()Lchat/ola/vn/signup/a;
    .locals 5

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/signup/OlaSignUpActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->n:Lchat/ola/vn/signup/a;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->n:Lchat/ola/vn/signup/a;

    invoke-virtual {v1}, Lchat/ola/vn/signup/a;->d()Lchat/ola/vn/signup/a;

    move-result-object v1

    if-eqz v1, :cond_0

    const v2, 0x7f01000a

    const v3, 0x7f01000c

    invoke-virtual {v0, v2, v3}, Landroid/support/v4/app/FragmentTransaction;->setCustomAnimations(II)Landroid/support/v4/app/FragmentTransaction;

    const v2, 0x7f090474

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v1, v3}, Landroid/support/v4/app/FragmentTransaction;->replace(ILandroid/support/v4/app/Fragment;Ljava/lang/String;)Landroid/support/v4/app/FragmentTransaction;

    invoke-virtual {v1}, Lchat/ola/vn/signup/a;->e_()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1}, Lchat/ola/vn/signup/a;->e()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1}, Lchat/ola/vn/signup/a;->h()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v2, v3, v4}, Lchat/ola/vn/signup/OlaSignUpActivity;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentTransaction;->commit()I

    iput-object v1, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->n:Lchat/ola/vn/signup/a;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->n:Lchat/ola/vn/signup/a;

    return-object v0
.end method

.method protected a()V
    .locals 2

    :try_start_0
    sget-object v0, Lchat/ola/vn/signup/OlaSignUpActivity;->m:Ljava/lang/String;

    if-nez v0, :cond_0

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->i(S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    return-void
.end method

.method public a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    .locals 15

    move-object v7, p0

    move/from16 v8, p1

    move-object/from16 v3, p2

    const/4 v0, 0x0

    invoke-virtual {v7, v0}, Lchat/ola/vn/signup/OlaSignUpActivity;->c(Z)V

    if-eqz p3, :cond_0

    :try_start_0
    sput-object p3, Lchat/ola/vn/signup/OlaSignUpActivity;->k:[B

    iget-object v0, v7, Lchat/ola/vn/signup/OlaSignUpActivity;->n:Lchat/ola/vn/signup/a;

    check-cast v0, Lchat/ola/vn/signup/e;

    invoke-virtual {v0}, Lchat/ola/vn/signup/e;->y()V

    goto :goto_0

    :cond_0
    sget-object v1, Lchat/ola/vn/signup/OlaSignUpActivity;->m:Ljava/lang/String;

    if-nez v1, :cond_1

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v1, v0}, Lchat/ola/vn/network/OlaNetworkService;->i(S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    :goto_0
    const-wide/16 v9, 0xc8

    const/16 v11, 0xa

    const/4 v12, 0x7

    const v13, 0x7f0f0280

    if-eq v8, v12, :cond_4

    if-eq v8, v11, :cond_4

    packed-switch v8, :pswitch_data_0

    :try_start_1
    invoke-virtual {v7}, Lchat/ola/vn/signup/OlaSignUpActivity;->C()Lchat/ola/vn/signup/a;

    new-instance v0, Lchat/ola/vn/signup/OlaSignUpActivity$3;

    invoke-direct {v0, v7}, Lchat/ola/vn/signup/OlaSignUpActivity$3;-><init>(Lchat/ola/vn/signup/OlaSignUpActivity;)V

    invoke-static {v0, v9, v10}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    invoke-static/range {p2 .. p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    invoke-virtual {v7, v13}, Lchat/ola/vn/signup/OlaSignUpActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {v7, v0, v3}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    :try_start_2
    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Reg nick MANUAL FAIL: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :goto_1
    invoke-virtual {v0, v1}, Lchat/ola/vn/util/f;->c(Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_4

    return-void

    :cond_2
    invoke-virtual {v7, v13}, Lchat/ola/vn/signup/OlaSignUpActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    const v1, 0x7f0f0263

    invoke-virtual {v7, v1}, Lchat/ola/vn/signup/OlaSignUpActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v7, v0, v1}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    return-void

    :pswitch_0
    :try_start_3
    iget-object v0, v7, Lchat/ola/vn/signup/OlaSignUpActivity;->n:Lchat/ola/vn/signup/a;

    instance-of v0, v0, Lchat/ola/vn/signup/b;

    if-nez v0, :cond_3

    iget-object v0, v7, Lchat/ola/vn/signup/OlaSignUpActivity;->n:Lchat/ola/vn/signup/a;

    :goto_2
    invoke-virtual {v7}, Lchat/ola/vn/signup/OlaSignUpActivity;->C()Lchat/ola/vn/signup/a;

    iget-object v1, v7, Lchat/ola/vn/signup/OlaSignUpActivity;->n:Lchat/ola/vn/signup/a;

    if-eq v0, v1, :cond_3

    iget-object v1, v7, Lchat/ola/vn/signup/OlaSignUpActivity;->n:Lchat/ola/vn/signup/a;

    instance-of v1, v1, Lchat/ola/vn/signup/b;

    if-nez v1, :cond_3

    goto :goto_2

    :cond_3
    new-instance v9, Lchat/ola/vn/signup/OlaSignUpActivity$2;

    move-object v0, v9

    move-object v1, v7

    move v2, v8

    move-object/from16 v4, p3

    move-object/from16 v5, p4

    move/from16 v6, p5

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/signup/OlaSignUpActivity$2;-><init>(Lchat/ola/vn/signup/OlaSignUpActivity;ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V

    const-wide/16 v0, 0x3e8

    invoke-static {v9, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    invoke-virtual {v7, v13}, Lchat/ola/vn/signup/OlaSignUpActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    const v1, 0x7f0f0258

    invoke-virtual {v7, v1}, Lchat/ola/vn/signup/OlaSignUpActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v7, v0, v1}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    :catch_2
    :try_start_4
    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object v0

    const-string v1, "Reg nick MANUAL FAIL: FAIL_BAD_PHONENUMBER_FORMAT"
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_4

    goto :goto_1

    :pswitch_1
    :try_start_5
    iget-object v0, v7, Lchat/ola/vn/signup/OlaSignUpActivity;->n:Lchat/ola/vn/signup/a;

    move v1, v8

    move-object v2, v3

    move-object/from16 v3, p3

    move-object/from16 v4, p4

    move/from16 v5, p5

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/signup/a;->a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_3

    :catch_3
    :try_start_6
    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object v0

    const-string v1, "Reg nick MANUAL FAIL: FAIL_WRONG_VERIFICATION_CODE"

    goto :goto_1

    :cond_4
    :pswitch_2
    invoke-virtual {v7}, Lchat/ola/vn/signup/OlaSignUpActivity;->C()Lchat/ola/vn/signup/a;

    new-instance v14, Lchat/ola/vn/signup/OlaSignUpActivity$1;

    move-object v0, v14

    move-object v1, v7

    move v2, v8

    move-object/from16 v4, p3

    move-object/from16 v5, p4

    move/from16 v6, p5

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/signup/OlaSignUpActivity$1;-><init>(Lchat/ola/vn/signup/OlaSignUpActivity;ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V

    invoke-static {v14, v9, v10}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    const/4 v0, 0x3

    if-ne v8, v0, :cond_5

    invoke-virtual {v7, v13}, Lchat/ola/vn/signup/OlaSignUpActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    const v1, 0x7f0f0265

    invoke-virtual {v7, v1}, Lchat/ola/vn/signup/OlaSignUpActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v7, v0, v1}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object v0

    const-string v1, "Reg nick MANUAL FAIL: FAIL_DUPLICATED_USERNAME"

    goto/16 :goto_1

    :cond_5
    if-ne v8, v12, :cond_6

    invoke-virtual {v7, v13}, Lchat/ola/vn/signup/OlaSignUpActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    const v1, 0x7f0f0266

    invoke-virtual {v7, v1}, Lchat/ola/vn/signup/OlaSignUpActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v7, v0, v1}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object v0

    const-string v1, "Reg nick MANUAL FAIL: FAIL_INVALID_USERNAME_PASSWORD"

    goto/16 :goto_1

    :cond_6
    if-ne v8, v11, :cond_7

    invoke-virtual {v7, v13}, Lchat/ola/vn/signup/OlaSignUpActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    const v1, 0x7f0f0253

    invoke-virtual {v7, v1}, Lchat/ola/vn/signup/OlaSignUpActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v7, v0, v1}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object v0

    const-string v1, "Reg nick MANUAL FAIL: FAIL_INVALID_PASSWORD"
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_4

    goto/16 :goto_1

    :catch_4
    :cond_7
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x2
        :pswitch_1
        :pswitch_2
        :pswitch_0
    .end packed-switch
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->o:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    const/4 v0, 0x4

    const/4 v1, 0x0

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->p:Landroid/widget/TextView;

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->p:Landroid/widget/TextView;

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->p:Landroid/widget/TextView;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_0
    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->r:Landroid/widget/TextView;

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->r:Landroid/widget/TextView;

    invoke-virtual {p1, p3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->r:Landroid/widget/TextView;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;S)V
    .locals 1

    const/4 p3, 0x0

    :try_start_0
    sput-boolean p3, Lchat/ola/vn/tutorial/OlaTutorialActivity;->f:Z

    invoke-virtual {p0, p3}, Lchat/ola/vn/signup/OlaSignUpActivity;->c(Z)V

    new-instance p3, Landroid/content/Intent;

    invoke-direct {p3}, Landroid/content/Intent;-><init>()V

    const-string v0, "_username"

    invoke-virtual {p3, v0, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string p1, "_pass"

    invoke-virtual {p3, p1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const/4 p1, -0x1

    invoke-virtual {p0, p1, p3}, Lchat/ola/vn/signup/OlaSignUpActivity;->setResult(ILandroid/content/Intent;)V

    const/4 p1, 0x1

    sput-boolean p1, Lchat/ola/vn/activity/OlaBottomTabActivity;->g:Z

    invoke-virtual {p0}, Lchat/ola/vn/signup/OlaSignUpActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object p1

    const-string p2, "Reg nick MANUAL OK"

    invoke-virtual {p1, p2}, Lchat/ola/vn/util/f;->c(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method public a([BS)V
    .locals 0

    const/4 p2, 0x0

    invoke-virtual {p0, p2}, Lchat/ola/vn/signup/OlaSignUpActivity;->c(Z)V

    sput-object p1, Lchat/ola/vn/signup/OlaSignUpActivity;->k:[B

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->n:Lchat/ola/vn/signup/a;

    check-cast p1, Lchat/ola/vn/signup/e;

    invoke-virtual {p1}, Lchat/ola/vn/signup/e;->y()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected b()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public c(Z)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->s:Ljava/lang/Runnable;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/signup/OlaSignUpActivity$4;

    invoke-direct {v0, p0}, Lchat/ola/vn/signup/OlaSignUpActivity$4;-><init>(Lchat/ola/vn/signup/OlaSignUpActivity;)V

    iput-object v0, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->s:Ljava/lang/Runnable;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->s:Ljava/lang/Runnable;

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->s:Ljava/lang/Runnable;

    const-wide/32 v0, 0xea60

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->q:Landroid/view/View;

    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->q:Landroid/view/View;

    const/16 v0, 0x8

    goto :goto_0

    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/signup/OlaSignUpActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onBackPressed()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/signup/OlaSignUpActivity;->D()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-super {p0}, Lchat/ola/vn/c;->onBackPressed()V

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/signup/OlaSignUpActivity;->C()Lchat/ola/vn/signup/a;

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
    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->n:Lchat/ola/vn/signup/a;

    invoke-virtual {p1}, Lchat/ola/vn/signup/a;->x()V

    return-void

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/signup/OlaSignUpActivity;->onBackPressed()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 3

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b016a

    invoke-virtual {p0, p1}, Lchat/ola/vn/signup/OlaSignUpActivity;->setContentView(I)V

    const p1, 0x7f09030e

    invoke-virtual {p0, p1}, Lchat/ola/vn/signup/OlaSignUpActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->q:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->q:Landroid/view/View;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    const p1, 0x7f0903a3

    invoke-virtual {p0, p1}, Lchat/ola/vn/signup/OlaSignUpActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->o:Landroid/widget/TextView;

    const p1, 0x7f09039c

    invoke-virtual {p0, p1}, Lchat/ola/vn/signup/OlaSignUpActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->p:Landroid/widget/TextView;

    const p1, 0x7f09039e

    invoke-virtual {p0, p1}, Lchat/ola/vn/signup/OlaSignUpActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->r:Landroid/widget/TextView;

    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->r:Landroid/widget/TextView;

    const/4 v0, 0x4

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->r:Landroid/widget/TextView;

    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/signup/OlaSignUpActivity;->getSupportFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object p1

    invoke-virtual {p1}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/signup/OlaSignUpActivity;->m:Ljava/lang/String;

    const v1, 0x7f090474

    if-nez v0, :cond_0

    const-class v0, Lchat/ola/vn/signup/b;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/signup/a;

    iput-object v0, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->n:Lchat/ola/vn/signup/a;

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->n:Lchat/ola/vn/signup/a;

    const-class v2, Lchat/ola/vn/signup/b;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    :goto_0
    invoke-virtual {p1, v1, v0, v2}, Landroid/support/v4/app/FragmentTransaction;->add(ILandroid/support/v4/app/Fragment;Ljava/lang/String;)Landroid/support/v4/app/FragmentTransaction;

    goto :goto_1

    :cond_0
    const-class v0, Lchat/ola/vn/signup/c;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/signup/a;

    iput-object v0, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->n:Lchat/ola/vn/signup/a;

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->n:Lchat/ola/vn/signup/a;

    const-class v2, Lchat/ola/vn/signup/c;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->n:Lchat/ola/vn/signup/a;

    invoke-virtual {v0}, Lchat/ola/vn/signup/a;->e_()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->n:Lchat/ola/vn/signup/a;

    invoke-virtual {v1}, Lchat/ola/vn/signup/a;->e()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->n:Lchat/ola/vn/signup/a;

    invoke-virtual {v2}, Lchat/ola/vn/signup/a;->h()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v0, v1, v2}, Lchat/ola/vn/signup/OlaSignUpActivity;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->p:Landroid/widget/TextView;

    const v1, 0x7f0f044d

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->p:Landroid/widget/TextView;

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpActivity;->p:Landroid/widget/TextView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    invoke-virtual {p1}, Landroid/support/v4/app/FragmentTransaction;->commit()I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method
