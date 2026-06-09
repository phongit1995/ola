.class Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2;->afterTextChanged(Landroid/text/Editable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2;


# direct methods
.method constructor <init>(Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2$1;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2$1;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2;

    iget-object v0, v0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {v0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->d(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-object v0, v1

    :catch_0
    :try_start_2
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    const/4 v2, 0x6

    if-lt v1, v2, :cond_0

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2$1;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2;

    iget-object v0, v0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {v0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->b(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Landroid/widget/TextView;

    move-result-object v0

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2$1;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2;

    iget-object v0, v0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {v0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->e(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)V

    return-void

    :cond_0
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2$1;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2;

    iget-object v0, v0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {v0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->b(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Landroid/widget/TextView;

    move-result-object v0

    sget v1, Lchat/ola/vn/f;->k:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2$1;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2;

    iget-object v0, v0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {v0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->b(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Landroid/widget/TextView;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2$1;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2;

    iget-object v0, v0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {v0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->b(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Landroid/widget/TextView;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2$1;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2;

    iget-object v1, v1, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    const v2, 0x7f0f025f

    invoke-virtual {v1, v2}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_1
    return-void
.end method
