.class Lchat/ola/vn/signup/OlaSignUpBySmsActivity$5;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/j;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->B()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$5;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;Z)V
    .locals 1

    const/4 p1, 0x0

    if-nez p2, :cond_0

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$5;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {p2}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->b(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Landroid/widget/TextView;

    move-result-object p2

    invoke-virtual {p2, p1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$5;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {p1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->b(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Landroid/widget/TextView;

    move-result-object p1

    sget p2, Lchat/ola/vn/f;->k:I

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$5;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {p1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->b(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Landroid/widget/TextView;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$5;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    const v0, 0x7f0f0265

    invoke-virtual {p2, v0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    :goto_0
    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$5;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {p2}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->b(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Landroid/widget/TextView;

    move-result-object p2

    sget v0, Lchat/ola/vn/f;->H:I

    invoke-virtual {p2, v0}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object p2, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$5;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {p2}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->b(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Landroid/widget/TextView;

    move-result-object p2

    invoke-virtual {p2, p1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$5;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {p1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->b(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Landroid/widget/TextView;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$5;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    const v0, 0x7f0f038c

    invoke-virtual {p2, v0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->getString(I)Ljava/lang/String;

    move-result-object p2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    return-void
.end method
