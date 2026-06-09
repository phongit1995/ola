.class public Lchat/ola/vn/tutorial/d;
.super Lchat/ola/vn/tutorial/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/activity/OlaCropImageActivity$a;


# static fields
.field private static a:Z = false


# instance fields
.field private b:Lchat/ola/vn/view/OlaCachedImageView;

.field private c:Landroid/widget/Button;

.field private d:Landroid/widget/Button;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/tutorial/c;-><init>()V

    return-void
.end method

.method private v()V
    .locals 1

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/tutorial/d;->j()Lchat/ola/vn/tutorial/OlaTutorialActivity;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lchat/ola/vn/tutorial/OlaTutorialActivity;->B()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method private x()V
    .locals 5

    :try_start_0
    sget-boolean v0, Lchat/ola/vn/r/a/e;->e:Z

    if-eqz v0, :cond_0

    iget-object v1, p0, Lchat/ola/vn/tutorial/d;->b:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v2, 0x0

    invoke-virtual {v1, v2, v2}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    :cond_0
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    iget-object v4, p0, Lchat/ola/vn/tutorial/d;->b:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v2, v3, v4, v0}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;ZLchat/ola/vn/view/OlaCachedImageView;Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public D()V
    .locals 3

    const/4 v0, 0x1

    :try_start_0
    sput-byte v0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->g:B

    iget-object v1, p0, Lchat/ola/vn/tutorial/d;->c:Landroid/widget/Button;

    const v2, 0x7f0f0574

    invoke-virtual {v1, v2}, Landroid/widget/Button;->setText(I)V

    iget-object v1, p0, Lchat/ola/vn/tutorial/d;->c:Landroid/widget/Button;

    const v2, 0x7f080128

    invoke-virtual {v1, v2}, Landroid/widget/Button;->setBackgroundResource(I)V

    iget-object v1, p0, Lchat/ola/vn/tutorial/d;->d:Landroid/widget/Button;

    const v2, 0x7f08011a

    invoke-virtual {v1, v2}, Landroid/widget/Button;->setBackgroundResource(I)V

    iget-object v1, p0, Lchat/ola/vn/tutorial/d;->c:Landroid/widget/Button;

    sget v2, Lchat/ola/vn/f;->C:I

    invoke-virtual {v1, v2}, Landroid/widget/Button;->setTextColor(I)V

    iget-object v1, p0, Lchat/ola/vn/tutorial/d;->d:Landroid/widget/Button;

    sget v2, Lchat/ola/vn/f;->y:I

    invoke-virtual {v1, v2}, Landroid/widget/Button;->setTextColor(I)V

    sput-boolean v0, Lchat/ola/vn/r/a/e;->e:Z

    invoke-direct {p0}, Lchat/ola/vn/tutorial/d;->x()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public E()V
    .locals 0

    return-void
.end method

.method public F()V
    .locals 0

    return-void
.end method

.method public G()V
    .locals 0

    return-void
.end method

.method protected b(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/tutorial/c;->b(Landroid/os/Bundle;)V

    invoke-direct {p0}, Lchat/ola/vn/tutorial/d;->x()V

    return-void
.end method

.method public b_()V
    .locals 0

    return-void
.end method

.method public c()Lchat/ola/vn/tutorial/c;
    .locals 2

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/g;->A()I

    move-result v0

    if-lez v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/tutorial/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const-class v1, Lchat/ola/vn/tutorial/e;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/tutorial/e;

    return-object v0

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/tutorial/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const-class v1, Lchat/ola/vn/tutorial/b;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/tutorial/b;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public d()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f0630

    :try_start_0
    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const-string v0, ""

    return-object v0
.end method

.method public e()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/tutorial/d;->v()V

    return-void
.end method

.method public e_()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f0401

    :try_start_0
    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const-string v0, ""

    return-object v0
.end method

.method public f(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f0900d0

    if-eq p1, v0, :cond_1

    const v0, 0x7f0902a1

    if-eq p1, v0, :cond_1

    const v0, 0x7f090478

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/tutorial/d;->v()V

    return-void

    :cond_1
    const/4 p1, 0x1

    sput-boolean p1, Lchat/ola/vn/tutorial/d;->a:Z

    iget-object p1, p0, Lchat/ola/vn/tutorial/d;->c:Landroid/widget/Button;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setVisibility(I)V

    invoke-virtual {p0}, Lchat/ola/vn/tutorial/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1, p0}, Lchat/ola/vn/activity/OlaCropImageActivity;->c(Landroid/content/Context;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 0

    const p2, 0x7f0b01c9

    const/4 p3, 0x0

    invoke-virtual {p1, p2, p3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    const p2, 0x7f0902a1

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p2, p0, Lchat/ola/vn/tutorial/d;->b:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object p2, p0, Lchat/ola/vn/tutorial/d;->b:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p2, p0}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f0900d0

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/Button;

    iput-object p2, p0, Lchat/ola/vn/tutorial/d;->d:Landroid/widget/Button;

    iget-object p2, p0, Lchat/ola/vn/tutorial/d;->d:Landroid/widget/Button;

    invoke-virtual {p2, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f090478

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/Button;

    iput-object p2, p0, Lchat/ola/vn/tutorial/d;->c:Landroid/widget/Button;

    iget-object p2, p0, Lchat/ola/vn/tutorial/d;->c:Landroid/widget/Button;

    invoke-virtual {p2, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    sget-boolean p2, Lchat/ola/vn/tutorial/d;->a:Z

    if-eqz p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/tutorial/d;->c:Landroid/widget/Button;

    const/4 p3, 0x0

    :goto_0
    invoke-virtual {p2, p3}, Landroid/widget/Button;->setVisibility(I)V

    return-object p1

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/tutorial/d;->c:Landroid/widget/Button;

    const/16 p3, 0x8

    goto :goto_0

    return-object p1
.end method
