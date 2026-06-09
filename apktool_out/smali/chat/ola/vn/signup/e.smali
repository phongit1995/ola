.class public Lchat/ola/vn/signup/e;
.super Lchat/ola/vn/signup/a;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private a:Landroid/widget/ImageView;

.field private b:Landroid/widget/EditText;

.field private c:Landroid/view/animation/Animation;

.field private d:Landroid/view/View;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/signup/a;-><init>()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/signup/e;)Landroid/widget/EditText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/signup/e;->b:Landroid/widget/EditText;

    return-object p0
.end method


# virtual methods
.method public a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    .locals 0

    const/4 p3, 0x2

    if-eq p1, p3, :cond_0

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_1

    invoke-virtual {p0}, Lchat/ola/vn/signup/e;->j()Lchat/ola/vn/signup/OlaSignUpActivity;

    move-result-object p1

    const p3, 0x7f0f0280

    invoke-virtual {p0, p3}, Lchat/ola/vn/signup/e;->getString(I)Ljava/lang/String;

    move-result-object p3

    invoke-static {p1, p3, p2}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    return-void

    :cond_0
    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/signup/e;->b:Landroid/widget/EditText;

    iget-object p2, p0, Lchat/ola/vn/signup/e;->c:Landroid/view/animation/Animation;

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object p1, p0, Lchat/ola/vn/signup/e;->b:Landroid/widget/EditText;

    const-string p2, ""

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {p0}, Lchat/ola/vn/signup/e;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const p2, 0x7f0f0269

    invoke-static {p1, p2}, Lchat/ola/vn/util/j;->d(Landroid/content/Context;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method protected b(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Lchat/ola/vn/signup/a;->b(Landroid/os/Bundle;)V

    invoke-virtual {p0}, Lchat/ola/vn/signup/e;->y()V

    new-instance p1, Lchat/ola/vn/signup/e$2;

    invoke-direct {p1, p0}, Lchat/ola/vn/signup/e$2;-><init>(Lchat/ola/vn/signup/e;)V

    const-wide/16 v0, 0x12c

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    return-void
.end method

.method public c()Lchat/ola/vn/signup/a;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method public e()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f042c

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public e_()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f05db

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public h()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f04f5

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f090373

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/signup/e;->x()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 3
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    const/4 p2, 0x0

    const p3, 0x7f0b016e

    invoke-virtual {p1, p3, p2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    const p3, 0x7f0905dc

    invoke-virtual {p1, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    check-cast p3, Landroid/widget/ImageView;

    iput-object p3, p0, Lchat/ola/vn/signup/e;->a:Landroid/widget/ImageView;

    const p3, 0x7f0905db

    invoke-virtual {p1, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    check-cast p3, Landroid/widget/EditText;

    iput-object p3, p0, Lchat/ola/vn/signup/e;->b:Landroid/widget/EditText;

    const p3, 0x7f0904ba

    invoke-virtual {p1, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    check-cast p3, Lcom/mg/ola/common/widget/OlaTextView;

    const v0, 0x7f0f0644

    invoke-virtual {p0, v0}, Lchat/ola/vn/signup/e;->getString(I)Ljava/lang/String;

    move-result-object v0

    sget v1, Lchat/ola/vn/f;->a:I

    const/4 v2, 0x1

    invoke-static {p3, v0, p2, v1, v2}, Lchat/ola/vn/util/i;->b(Landroid/view/View;Ljava/lang/CharSequence;Lcom/mg/ola/common/widget/OlaTextView$b;IZ)Ljava/lang/CharSequence;

    move-result-object p2

    invoke-virtual {p3, p2}, Lcom/mg/ola/common/widget/OlaTextView;->setText(Ljava/lang/CharSequence;)V

    invoke-static {}, Lchat/ola/vn/q/a;->a()Lchat/ola/vn/q/a;

    move-result-object p2

    invoke-virtual {p3, p2}, Lcom/mg/ola/common/widget/OlaTextView;->setOlaSpanClickListener(Lcom/mg/ola/common/widget/OlaTextView$b;)V

    iget-object p2, p0, Lchat/ola/vn/signup/e;->b:Landroid/widget/EditText;

    new-instance p3, Lchat/ola/vn/signup/e$1;

    invoke-direct {p3, p0}, Lchat/ola/vn/signup/e$1;-><init>(Lchat/ola/vn/signup/e;)V

    invoke-virtual {p2, p3}, Landroid/widget/EditText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    invoke-virtual {p0}, Lchat/ola/vn/signup/e;->j()Lchat/ola/vn/signup/OlaSignUpActivity;

    move-result-object p2

    const p3, 0x7f010042

    invoke-static {p2, p3}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/signup/e;->c:Landroid/view/animation/Animation;

    const p2, 0x7f090373

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/signup/e;->d:Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/signup/e;->d:Landroid/view/View;

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-object p1
.end method

.method public x()V
    .locals 11

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/signup/e;->b:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v8}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/signup/e;->b:Landroid/widget/EditText;

    iget-object v1, p0, Lchat/ola/vn/signup/e;->c:Landroid/view/animation/Animation;

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V

    invoke-virtual {p0}, Lchat/ola/vn/signup/e;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const v1, 0x7f0f0259

    invoke-static {v0, v1}, Lchat/ola/vn/util/j;->d(Landroid/content/Context;I)V

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/signup/e;->j()Lchat/ola/vn/signup/OlaSignUpActivity;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lchat/ola/vn/signup/OlaSignUpActivity;->c(Z)V

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    sget-object v2, Lchat/ola/vn/signup/OlaSignUpActivity;->e:Ljava/lang/String;

    sget-object v3, Lchat/ola/vn/signup/OlaSignUpActivity;->f:Ljava/lang/String;

    sget-object v4, Lchat/ola/vn/signup/OlaSignUpActivity;->g:Ljava/lang/String;

    sget-object v5, Lchat/ola/vn/signup/OlaSignUpActivity;->h:Ljava/lang/String;

    sget-object v6, Lchat/ola/vn/signup/OlaSignUpActivity;->i:Ljava/lang/String;

    sget-object v7, Lchat/ola/vn/signup/OlaSignUpActivity;->j:Ljava/lang/Long;

    sget-byte v9, Lchat/ola/vn/signup/OlaSignUpActivity;->l:B

    const/4 v10, 0x0

    invoke-virtual/range {v1 .. v10}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Long;Ljava/lang/String;BS)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public y()V
    .locals 4

    :try_start_0
    sget-object v0, Lchat/ola/vn/signup/OlaSignUpActivity;->k:[B

    const/4 v1, 0x0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/signup/e;->j()Lchat/ola/vn/signup/OlaSignUpActivity;

    move-result-object v0

    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Lchat/ola/vn/signup/OlaSignUpActivity;->c(Z)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->i(S)V

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/signup/e;->j()Lchat/ola/vn/signup/OlaSignUpActivity;

    move-result-object v0

    invoke-virtual {v0, v1}, Lchat/ola/vn/signup/OlaSignUpActivity;->c(Z)V

    iget-object v0, p0, Lchat/ola/vn/signup/e;->a:Landroid/widget/ImageView;

    sget-object v2, Lchat/ola/vn/signup/OlaSignUpActivity;->k:[B

    sget-object v3, Lchat/ola/vn/signup/OlaSignUpActivity;->k:[B

    array-length v3, v3

    invoke-static {v2, v1, v3}, Landroid/graphics/BitmapFactory;->decodeByteArray([BII)Landroid/graphics/Bitmap;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
