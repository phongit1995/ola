.class Lchat/ola/vn/signup/OlaSignUpBySmsActivity$6;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/j;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->C()V
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

    iput-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$6;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private a(Ljava/lang/String;)V
    .locals 6

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-object v2, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$6;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {v2}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->j(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)J

    move-result-wide v2

    sub-long v4, v0, v2

    const-wide/16 v0, 0x7530

    cmp-long v2, v4, v0

    if-lez v2, :cond_0

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$6;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-static {v0, v1, v2}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->a(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;J)J

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$6;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->a(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;Z)V

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$6;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    const-string v1, "8055"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "MGM DK "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, v1, p1}, Lchat/ola/vn/sms/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;Z)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$6;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->c(Z)V

    if-nez p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$6;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {p1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->b(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Landroid/widget/TextView;

    move-result-object p1

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$6;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {p1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->b(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Landroid/widget/TextView;

    move-result-object p1

    sget p2, Lchat/ola/vn/f;->k:I

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$6;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {p1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->b(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Landroid/widget/TextView;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$6;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    const v0, 0x7f0f0265

    invoke-virtual {p2, v0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_0
    invoke-static {}, Lchat/ola/vn/c;->x()Z

    move-result p2

    if-eqz p2, :cond_1

    iget-object p2, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$6;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {p2}, Lchat/ola/vn/util/n;->b(Landroid/content/Context;)Z

    move-result p2

    if-eqz p2, :cond_1

    iget-object p2, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$6;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {p2}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->b(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Landroid/widget/TextView;

    move-result-object p2

    sget v0, Lchat/ola/vn/f;->H:I

    invoke-virtual {p2, v0}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object p2, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$6;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {p2}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->b(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Landroid/widget/TextView;

    move-result-object p2

    invoke-virtual {p2, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p2, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$6;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {p2}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->b(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Landroid/widget/TextView;

    move-result-object p2

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$6;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    const v1, 0x7f0f038c

    invoke-virtual {v0, v1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-direct {p0, p1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$6;->a(Ljava/lang/String;)V

    return-void

    :cond_1
    sput-object p1, Lchat/ola/vn/signup/c;->a:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$6;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {p1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->i(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
