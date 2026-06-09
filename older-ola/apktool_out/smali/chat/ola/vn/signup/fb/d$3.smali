.class Lchat/ola/vn/signup/fb/d$3;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/network/c;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/signup/fb/d;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/signup/fb/d;


# direct methods
.method constructor <init>(Lchat/ola/vn/signup/fb/d;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 3

    const/4 v0, 0x1

    :try_start_0
    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object v1

    const-string v2, "Reg nick by FB OK"

    invoke-virtual {v1, v2}, Lchat/ola/vn/util/f;->c(Ljava/lang/String;)V

    sput-boolean v0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->f:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v1, :cond_0

    invoke-static {p1}, Lchat/ola/vn/h;->d(Ljava/lang/String;)V

    invoke-static {p2}, Lchat/ola/vn/h;->b(Ljava/lang/String;)V

    invoke-static {p3}, Lchat/ola/vn/h;->c(Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v1

    invoke-virtual {v1, p1}, Lchat/ola/vn/e;->a(Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v1

    invoke-virtual {v1, p3}, Lchat/ola/vn/e;->b(Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v1

    const/4 v2, 0x0

    invoke-static {v1, p1, p2, p3, v2}, Lchat/ola/vn/h/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p2, p1}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;)V

    :cond_0
    const/4 p1, 0x0

    sput-boolean p1, Lchat/ola/vn/tutorial/OlaTutorialActivity;->e:Z

    sput-boolean v0, Lchat/ola/vn/activity/OlaBottomTabActivity;->g:Z

    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-virtual {p1}, Lchat/ola/vn/signup/fb/d;->v()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method public a(Ljava/lang/String;Z)V
    .locals 3

    const/4 p1, 0x4

    const/4 v0, 0x0

    if-eqz p2, :cond_0

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {p2}, Lchat/ola/vn/signup/fb/d;->c(Lchat/ola/vn/signup/fb/d;)Landroid/widget/TextView;

    move-result-object p2

    invoke-virtual {p2, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p2, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {p2}, Lchat/ola/vn/signup/fb/d;->c(Lchat/ola/vn/signup/fb/d;)Landroid/widget/TextView;

    move-result-object p2

    sget v0, Lchat/ola/vn/f;->k:I

    invoke-virtual {p2, v0}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object p2, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {p2}, Lchat/ola/vn/signup/fb/d;->c(Lchat/ola/vn/signup/fb/d;)Landroid/widget/TextView;

    move-result-object p2

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    const v1, 0x7f0f0265

    invoke-virtual {v0, v1}, Lchat/ola/vn/signup/fb/d;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p2, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {p2}, Lchat/ola/vn/signup/fb/d;->e(Lchat/ola/vn/signup/fb/d;)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2, p1}, Landroid/view/View;->setVisibility(I)V

    iget-object p2, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {p2}, Lchat/ola/vn/signup/fb/d;->f(Lchat/ola/vn/signup/fb/d;)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2, p1}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {p2}, Lchat/ola/vn/signup/fb/d;->c(Lchat/ola/vn/signup/fb/d;)Landroid/widget/TextView;

    move-result-object p2

    sget v1, Lchat/ola/vn/f;->H:I

    invoke-virtual {p2, v1}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object p2, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {p2}, Lchat/ola/vn/signup/fb/d;->c(Lchat/ola/vn/signup/fb/d;)Landroid/widget/TextView;

    move-result-object p2

    invoke-virtual {p2, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p2, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {p2}, Lchat/ola/vn/signup/fb/d;->c(Lchat/ola/vn/signup/fb/d;)Landroid/widget/TextView;

    move-result-object p2

    iget-object v1, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    const v2, 0x7f0f038c

    invoke-virtual {v1, v2}, Lchat/ola/vn/signup/fb/d;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p2, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p2, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {p2}, Lchat/ola/vn/signup/fb/d;->e(Lchat/ola/vn/signup/fb/d;)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2, p1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {p1}, Lchat/ola/vn/signup/fb/d;->f(Lchat/ola/vn/signup/fb/d;)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public a(S)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-virtual {v0}, Lchat/ola/vn/signup/fb/d;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->c(Z)V

    if-eqz p1, :cond_5

    const/4 v0, 0x3

    if-eq p1, v0, :cond_4

    const/4 v0, 0x7

    if-eq p1, v0, :cond_3

    const/16 v0, 0xa

    if-eq p1, v0, :cond_2

    const/16 v0, 0x16

    if-eq p1, v0, :cond_1

    const/16 v0, 0x20

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object p1

    const-string v0, "Reg nick by FB FAIL: FAIL_LOGIN_SERVER_BUSY"

    invoke-virtual {p1, v0}, Lchat/ola/vn/util/f;->c(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-virtual {p1}, Lchat/ola/vn/signup/fb/d;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    const v1, 0x7f0f0358

    invoke-virtual {v0, v1}, Lchat/ola/vn/signup/fb/d;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/util/j;->c(Landroid/content/Context;Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-virtual {p1}, Lchat/ola/vn/signup/fb/d;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/activity/OlaLoginActivity;->a(Landroid/content/Context;)Z

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-virtual {p1}, Lchat/ola/vn/signup/fb/d;->v()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_5

    return-void

    :cond_1
    :try_start_2
    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object p1

    const-string v0, "Reg nick by FB FAIL: FAIL_INACTIVATED_ACCOUNT"

    invoke-virtual {p1, v0}, Lchat/ola/vn/util/f;->c(Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :try_start_3
    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-virtual {p1}, Lchat/ola/vn/signup/fb/d;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    const v1, 0x7f0f04eb

    invoke-virtual {v0, v1}, Lchat/ola/vn/signup/fb/d;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/util/j;->c(Landroid/content/Context;Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-virtual {p1}, Lchat/ola/vn/signup/fb/d;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/activity/OlaLoginActivity;->a(Landroid/content/Context;)Z
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_5

    goto :goto_0

    :cond_2
    :try_start_4
    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object p1

    const-string v0, "Reg nick by FB FAIL: FAIL_INVALID_PASSWORD"

    invoke-virtual {p1, v0}, Lchat/ola/vn/util/f;->c(Ljava/lang/String;)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    :catch_2
    :try_start_5
    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-virtual {p1}, Lchat/ola/vn/signup/fb/d;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    const v1, 0x7f0f0253

    invoke-virtual {v0, v1}, Lchat/ola/vn/signup/fb/d;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/util/j;->c(Landroid/content/Context;Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-virtual {p1}, Lchat/ola/vn/signup/fb/d;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/activity/OlaLoginActivity;->a(Landroid/content/Context;)Z
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_5

    goto :goto_0

    :cond_3
    :try_start_6
    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object p1

    const-string v0, "Reg nick by FB FAIL: FAIL_INVALID_USERNAME_PASSWORD"

    invoke-virtual {p1, v0}, Lchat/ola/vn/util/f;->c(Ljava/lang/String;)V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_3

    :catch_3
    :try_start_7
    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-virtual {p1}, Lchat/ola/vn/signup/fb/d;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    const v1, 0x7f0f0268

    invoke-virtual {v0, v1}, Lchat/ola/vn/signup/fb/d;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/util/j;->c(Landroid/content/Context;Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-virtual {p1}, Lchat/ola/vn/signup/fb/d;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/activity/OlaLoginActivity;->a(Landroid/content/Context;)Z
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_5

    goto :goto_0

    :cond_4
    :try_start_8
    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object p1

    const-string v0, "Reg nick by FB FAIL: FAIL_DUPLICATED_USERNAME"

    invoke-virtual {p1, v0}, Lchat/ola/vn/util/f;->c(Ljava/lang/String;)V
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_4

    :catch_4
    :try_start_9
    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {p1}, Lchat/ola/vn/signup/fb/d;->c(Lchat/ola/vn/signup/fb/d;)Landroid/widget/TextView;

    move-result-object p1

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {p1}, Lchat/ola/vn/signup/fb/d;->c(Lchat/ola/vn/signup/fb/d;)Landroid/widget/TextView;

    move-result-object p1

    sget v0, Lchat/ola/vn/f;->k:I

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {p1}, Lchat/ola/vn/signup/fb/d;->c(Lchat/ola/vn/signup/fb/d;)Landroid/widget/TextView;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    const v1, 0x7f0f0265

    invoke-virtual {v0, v1}, Lchat/ola/vn/signup/fb/d;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {p1}, Lchat/ola/vn/signup/fb/d;->e(Lchat/ola/vn/signup/fb/d;)Landroid/view/View;

    move-result-object p1

    const/4 v0, 0x4

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {p1}, Lchat/ola/vn/signup/fb/d;->f(Lchat/ola/vn/signup/fb/d;)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_5
    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-virtual {p1}, Lchat/ola/vn/signup/fb/d;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    const v1, 0x7f0f0263

    invoke-virtual {v0, v1}, Lchat/ola/vn/signup/fb/d;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/util/j;->c(Landroid/content/Context;Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-virtual {p1}, Lchat/ola/vn/signup/fb/d;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/activity/OlaLoginActivity;->a(Landroid/content/Context;)Z
    :try_end_9
    .catch Ljava/lang/Throwable; {:try_start_9 .. :try_end_9} :catch_5

    goto/16 :goto_0

    :catch_5
    return-void
.end method

.method public b()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-virtual {v0}, Lchat/ola/vn/signup/fb/d;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->c(Z)V

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public b(Ljava/util/List;)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    if-nez p1, :cond_0

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    :cond_0
    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_2

    invoke-static {}, Lcom/mg/ola/common/d/g;->f()Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-virtual {v0}, Lchat/ola/vn/signup/fb/d;->e()Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->getApplication()Landroid/app/Application;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Application;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    sget-object v2, Landroid/provider/ContactsContract$Profile;->CONTENT_URI:Landroid/net/Uri;

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-virtual/range {v1 .. v6}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v0

    invoke-interface {v0}, Landroid/database/Cursor;->moveToFirst()Z

    const-string v1, "display_name"

    invoke-interface {v0, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v0, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    invoke-static {v1}, Lchat/ola/vn/util/m;->r(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    invoke-interface {p1, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    invoke-interface {v0}, Landroid/database/Cursor;->close()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_2
    :goto_0
    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {v0}, Lchat/ola/vn/signup/fb/d;->h(Lchat/ola/vn/signup/fb/d;)Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    invoke-static {v0, v1}, Lchat/ola/vn/signup/fb/d;->a(Lchat/ola/vn/signup/fb/d;Ljava/util/List;)Ljava/util/List;

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {p1}, Lchat/ola/vn/signup/fb/d;->h(Lchat/ola/vn/signup/fb/d;)Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_3

    if-lez p1, :cond_4

    const/4 p1, 0x0

    :try_start_2
    iget-object v0, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {v0}, Lchat/ola/vn/signup/fb/d;->b(Lchat/ola/vn/signup/fb/d;)Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :try_start_3
    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_1

    :catch_1
    move-object p1, v0

    :catch_2
    :goto_1
    :try_start_4
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {p1}, Lchat/ola/vn/signup/fb/d;->b(Lchat/ola/vn/signup/fb/d;)Landroid/widget/EditText;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {v0}, Lchat/ola/vn/signup/fb/d;->h(Lchat/ola/vn/signup/fb/d;)Ljava/util/List;

    move-result-object v0

    const/4 v1, 0x0

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {p1}, Lchat/ola/vn/signup/fb/d;->b(Lchat/ola/vn/signup/fb/d;)Landroid/widget/EditText;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {v0}, Lchat/ola/vn/signup/fb/d;->b(Lchat/ola/vn/signup/fb/d;)Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->length()I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setSelection(I)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    goto :goto_2

    :catch_3
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_4
    :goto_2
    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$3;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {p1}, Lchat/ola/vn/signup/fb/d;->i(Lchat/ola/vn/signup/fb/d;)V

    return-void
.end method

.method public b(S)V
    .locals 0

    return-void
.end method

.method public c()V
    .locals 0

    return-void
.end method

.method public d()V
    .locals 0

    return-void
.end method
