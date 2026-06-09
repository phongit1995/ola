.class Lchat/ola/vn/signup/c$5;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/j;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/signup/c;->x()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lchat/ola/vn/signup/c;


# direct methods
.method constructor <init>(Lchat/ola/vn/signup/c;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/c$5;->b:Lchat/ola/vn/signup/c;

    iput-object p2, p0, Lchat/ola/vn/signup/c$5;->a:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;Z)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/signup/c$5;->b:Lchat/ola/vn/signup/c;

    invoke-virtual {v0}, Lchat/ola/vn/signup/c;->j()Lchat/ola/vn/signup/OlaSignUpActivity;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/signup/OlaSignUpActivity;->c(Z)V

    if-nez p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/signup/c$5;->b:Lchat/ola/vn/signup/c;

    invoke-static {p1}, Lchat/ola/vn/signup/c;->c(Lchat/ola/vn/signup/c;)Landroid/widget/EditText;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/signup/c$5;->b:Lchat/ola/vn/signup/c;

    invoke-static {p2}, Lchat/ola/vn/signup/c;->i(Lchat/ola/vn/signup/c;)Landroid/view/animation/Animation;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object p1, p0, Lchat/ola/vn/signup/c$5;->b:Lchat/ola/vn/signup/c;

    invoke-static {p1}, Lchat/ola/vn/signup/c;->a(Lchat/ola/vn/signup/c;)Landroid/widget/TextView;

    move-result-object p1

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/c$5;->b:Lchat/ola/vn/signup/c;

    invoke-static {p1}, Lchat/ola/vn/signup/c;->a(Lchat/ola/vn/signup/c;)Landroid/widget/TextView;

    move-result-object p1

    sget p2, Lchat/ola/vn/f;->k:I

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/c$5;->b:Lchat/ola/vn/signup/c;

    invoke-static {p1}, Lchat/ola/vn/signup/c;->a(Lchat/ola/vn/signup/c;)Landroid/widget/TextView;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/signup/c$5;->b:Lchat/ola/vn/signup/c;

    const v0, 0x7f0f0265

    invoke-virtual {p2, v0}, Lchat/ola/vn/signup/c;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/signup/c$5;->b:Lchat/ola/vn/signup/c;

    invoke-static {p2}, Lchat/ola/vn/signup/c;->a(Lchat/ola/vn/signup/c;)Landroid/widget/TextView;

    move-result-object p2

    sget v0, Lchat/ola/vn/f;->H:I

    invoke-virtual {p2, v0}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object p2, p0, Lchat/ola/vn/signup/c$5;->b:Lchat/ola/vn/signup/c;

    invoke-static {p2}, Lchat/ola/vn/signup/c;->a(Lchat/ola/vn/signup/c;)Landroid/widget/TextView;

    move-result-object p2

    invoke-virtual {p2, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p2, p0, Lchat/ola/vn/signup/c$5;->b:Lchat/ola/vn/signup/c;

    invoke-static {p2}, Lchat/ola/vn/signup/c;->a(Lchat/ola/vn/signup/c;)Landroid/widget/TextView;

    move-result-object p2

    iget-object v0, p0, Lchat/ola/vn/signup/c$5;->b:Lchat/ola/vn/signup/c;

    const v1, 0x7f0f038c

    invoke-virtual {v0, v1}, Lchat/ola/vn/signup/c;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    sput-object p1, Lchat/ola/vn/signup/OlaSignUpActivity;->e:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/signup/c$5;->a:Ljava/lang/String;

    sput-object p1, Lchat/ola/vn/signup/OlaSignUpActivity;->f:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/signup/c$5;->b:Lchat/ola/vn/signup/c;

    invoke-virtual {p1}, Lchat/ola/vn/signup/c;->j()Lchat/ola/vn/signup/OlaSignUpActivity;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/signup/OlaSignUpActivity;->B()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
