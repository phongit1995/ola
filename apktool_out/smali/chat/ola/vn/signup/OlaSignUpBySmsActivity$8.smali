.class Lchat/ola/vn/signup/OlaSignUpBySmsActivity$8;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->f(Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$8;->b:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    iput-object p2, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$8;->a:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$8;->b:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->a(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;Z)V

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$8;->a:Ljava/lang/String;

    const/16 v2, 0x3c

    const/16 v3, 0x3e

    invoke-static {v0, v2, v3}, Lchat/ola/vn/util/i;->a(Ljava/lang/String;CC)Ljava/util/ArrayList;

    move-result-object v0

    const/4 v2, 0x2

    if-eqz v0, :cond_0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v3

    if-ge v3, v2, :cond_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$8;->a:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/i;->a(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v0

    :cond_1
    if-eqz v0, :cond_2

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v3

    if-lt v3, v2, :cond_2

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    const/4 v3, 0x1

    invoke-interface {v0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iget-object v4, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$8;->b:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-virtual {v4, v1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->c(Z)V

    new-instance v4, Landroid/content/Intent;

    invoke-direct {v4}, Landroid/content/Intent;-><init>()V

    const-string v5, "_username"

    invoke-virtual {v4, v5, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v2, "_pass"

    invoke-virtual {v4, v2, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$8;->b:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    const/4 v2, -0x1

    invoke-virtual {v0, v2, v4}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->setResult(ILandroid/content/Intent;)V

    sput-boolean v3, Lchat/ola/vn/tutorial/OlaTutorialActivity;->e:Z

    sput-boolean v3, Lchat/ola/vn/activity/OlaBottomTabActivity;->g:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object v0

    const-string v2, "Reg nick by SMS OK"

    invoke-virtual {v0, v2}, Lchat/ola/vn/util/f;->c(Ljava/lang/String;)V

    sput-boolean v1, Lchat/ola/vn/tutorial/OlaTutorialActivity;->f:Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$8;->b:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-virtual {v0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->finish()V

    return-void

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$8;->b:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {v0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->d(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/signup/c;->a:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$8;->b:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {v0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->i(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method
