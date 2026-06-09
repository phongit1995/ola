.class public Lchat/ola/vn/activity/OlaChangePasswordActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;


# static fields
.field private static k:Ljava/lang/String;


# instance fields
.field private e:Landroid/view/animation/Animation;

.field private f:Landroid/widget/EditText;

.field private g:Landroid/widget/EditText;

.field private h:Landroid/widget/EditText;

.field private i:Ljava/lang/Runnable;

.field private j:Landroid/app/ProgressDialog;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->i:Ljava/lang/Runnable;

    return-void
.end method

.method private B()V
    .locals 4

    :try_start_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->f:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->g:Landroid/widget/EditText;

    invoke-virtual {v2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    const/16 v3, 0x26

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/network/OlaNetworkService;->g(Ljava/lang/String;Ljava/lang/String;S)V

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaChangePasswordActivity;->c(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private C()Z
    .locals 7

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->f:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const v1, 0x7f0f01c0

    const/4 v2, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->f:Landroid/widget/EditText;

    iget-object v3, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->e:Landroid/view/animation/Animation;

    invoke-virtual {v0, v3}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->f:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->requestFocus()Z

    invoke-static {p0, v1}, Lchat/ola/vn/util/j;->a(Landroid/content/Context;I)V

    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    const/4 v0, 0x1

    :goto_0
    iget-object v3, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->g:Landroid/widget/EditText;

    invoke-virtual {v3}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    const/4 v5, 0x6

    if-nez v4, :cond_1

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    if-ge v4, v5, :cond_2

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->g:Landroid/widget/EditText;

    iget-object v4, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->e:Landroid/view/animation/Animation;

    invoke-virtual {v0, v4}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->g:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->requestFocus()Z

    invoke-static {p0, v1}, Lchat/ola/vn/util/j;->a(Landroid/content/Context;I)V

    const/4 v0, 0x0

    :cond_2
    iget-object v4, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->h:Landroid/widget/EditText;

    invoke-virtual {v4}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v6

    if-nez v6, :cond_3

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v6

    if-ge v6, v5, :cond_4

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->h:Landroid/widget/EditText;

    iget-object v5, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->e:Landroid/view/animation/Animation;

    invoke-virtual {v0, v5}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->h:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->requestFocus()Z

    invoke-static {p0, v1}, Lchat/ola/vn/util/j;->a(Landroid/content/Context;I)V

    const/4 v0, 0x0

    :cond_4
    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_5

    const v0, 0x7f0f0280

    const v1, 0x7f0f01c2

    invoke-static {p0, v0, v1}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->h:Landroid/widget/EditText;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->e:Landroid/view/animation/Animation;

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->h:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->requestFocus()Z

    const/4 v0, 0x0

    :cond_5
    return v0
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaChangePasswordActivity;)Landroid/app/ProgressDialog;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->j:Landroid/app/ProgressDialog;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaChangePasswordActivity;Landroid/app/ProgressDialog;)Landroid/app/ProgressDialog;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->j:Landroid/app/ProgressDialog;

    return-object p1
.end method

.method public static a(Landroid/content/Context;)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, v0}, Lchat/ola/vn/activity/OlaChangePasswordActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1

    sput-object p1, Lchat/ola/vn/activity/OlaChangePasswordActivity;->k:Ljava/lang/String;

    new-instance p1, Landroid/content/Intent;

    const-class v0, Lchat/ola/vn/activity/OlaChangePasswordActivity;

    invoke-direct {p1, p0, v0}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, p1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    return-void
.end method

.method private c(Z)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->i:Ljava/lang/Runnable;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/activity/OlaChangePasswordActivity$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaChangePasswordActivity$2;-><init>(Lchat/ola/vn/activity/OlaChangePasswordActivity;)V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->i:Ljava/lang/Runnable;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->i:Ljava/lang/Runnable;

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->j:Landroid/app/ProgressDialog;

    if-nez p1, :cond_1

    const p1, 0x7f0f05ad

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaChangePasswordActivity;->getString(I)Ljava/lang/String;

    move-result-object p1

    const v0, 0x7f0f01c3

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChangePasswordActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, p1, v0}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/ProgressDialog;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->j:Landroid/app/ProgressDialog;

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->j:Landroid/app/ProgressDialog;

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->show()V

    goto :goto_1

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->j:Landroid/app/ProgressDialog;

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->isShowing()Z

    move-result p1

    if-nez p1, :cond_2

    goto :goto_0

    :cond_2
    :goto_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->i:Ljava/lang/Runnable;

    const-wide/16 v0, 0x7530

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->b(Ljava/lang/Runnable;J)Ljava/util/concurrent/ScheduledFuture;

    return-void

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->j:Landroid/app/ProgressDialog;

    if-eqz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->j:Landroid/app/ProgressDialog;

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->dismiss()V

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->j:Landroid/app/ProgressDialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_4
    return-void
.end method


# virtual methods
.method protected a()V
    .locals 0

    return-void
.end method

.method public a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    .locals 0

    invoke-super/range {p0 .. p5}, Lchat/ola/vn/c;->a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V

    const/16 p3, 0x26

    if-ne p5, p3, :cond_3

    const/4 p3, 0x0

    invoke-direct {p0, p3}, Lchat/ola/vn/activity/OlaChangePasswordActivity;->c(Z)V

    const/4 p3, 0x7

    const p4, 0x7f0f0280

    if-eq p1, p3, :cond_2

    const/16 p3, 0xa

    if-eq p1, p3, :cond_1

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_0

    invoke-virtual {p0, p4}, Lchat/ola/vn/activity/OlaChangePasswordActivity;->getString(I)Ljava/lang/String;

    move-result-object p1

    :goto_0
    invoke-static {p0, p1, p2}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    goto :goto_1

    :cond_0
    invoke-virtual {p0, p4}, Lchat/ola/vn/activity/OlaChangePasswordActivity;->getString(I)Ljava/lang/String;

    move-result-object p1

    const p2, 0x7f0f0263

    invoke-virtual {p0, p2}, Lchat/ola/vn/activity/OlaChangePasswordActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    goto :goto_0

    :cond_1
    const p1, 0x7f0f0253

    invoke-static {p0, p4, p1}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->g:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->requestFocus()Z

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->g:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->selectAll()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->h:Landroid/widget/EditText;

    const-string p2, ""

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_2
    const p1, 0x7f0f01c4

    invoke-static {p0, p4, p1}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->f:Landroid/widget/EditText;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->e:Landroid/view/animation/Animation;

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->f:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->requestFocus()Z

    :cond_3
    return-void
.end method

.method public b(S)V
    .locals 6

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaChangePasswordActivity;->c(Z)V

    new-instance v5, Lchat/ola/vn/activity/OlaChangePasswordActivity$1;

    invoke-direct {v5, p0}, Lchat/ola/vn/activity/OlaChangePasswordActivity$1;-><init>(Lchat/ola/vn/activity/OlaChangePasswordActivity;)V

    const v1, 0x7f0f0280

    const v2, 0x7f0f01c1

    const v3, 0x7f0f0480

    const/4 v4, 0x0

    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f0900b2

    if-eq p1, v0, :cond_1

    const v0, 0x7f09039c

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaChangePasswordActivity;->finish()V

    return-void

    :cond_1
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChangePasswordActivity;->C()Z

    move-result p1

    if-eqz p1, :cond_2

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChangePasswordActivity;->B()V

    :cond_2
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 4

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b0034

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaChangePasswordActivity;->setContentView(I)V

    const p1, 0x7f0903a3

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaChangePasswordActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const v1, 0x7f0f045f

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    const v0, 0x7f090574

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChangePasswordActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->f:Landroid/widget/EditText;

    invoke-static {}, Lchat/ola/vn/h;->b()Ljava/lang/String;

    move-result-object v0

    :try_start_0
    sget-object v1, Lchat/ola/vn/activity/OlaChangePasswordActivity;->k:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    const/16 v2, 0x8

    const v3, 0x7f0f010a

    if-nez v1, :cond_0

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaChangePasswordActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    invoke-virtual {p1, v3}, Landroid/widget/TextView;->setText(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->f:Landroid/widget/EditText;

    sget-object v0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->k:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->f:Landroid/widget/EditText;

    invoke-virtual {p1, v2}, Landroid/widget/EditText;->setVisibility(I)V

    goto :goto_1

    :cond_0
    invoke-static {v0}, Lchat/ola/vn/h;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaChangePasswordActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    invoke-virtual {p1, v3}, Landroid/widget/TextView;->setText(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->f:Landroid/widget/EditText;

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_1
    :goto_1
    const p1, 0x7f090565

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaChangePasswordActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->g:Landroid/widget/EditText;

    const p1, 0x7f09057f

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaChangePasswordActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->h:Landroid/widget/EditText;

    const p1, 0x7f0900b2

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaChangePasswordActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f09039c

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaChangePasswordActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f010042

    invoke-static {p0, p1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity;->e:Landroid/view/animation/Animation;

    return-void
.end method
