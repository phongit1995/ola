.class public Lchat/ola/vn/mediastore/a;
.super Ljava/lang/Object;


# instance fields
.field public a:I

.field public b:I

.field public c:Ljava/lang/String;

.field public d:Landroid/view/View;

.field public e:Z

.field public f:Landroid/view/View$OnClickListener;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/mediastore/a;->e:Z

    return-void
.end method


# virtual methods
.method public a(Landroid/app/Activity;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/mediastore/a;->d:Landroid/view/View;

    if-eqz v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    iget v0, p0, Lchat/ola/vn/mediastore/a;->a:I

    invoke-virtual {p1, v0}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/mediastore/a;->d:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/mediastore/a;->d:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/mediastore/a;->c:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/mediastore/a;->d:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/mediastore/a;->f:Landroid/view/View$OnClickListener;

    invoke-virtual {p1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-boolean p1, p0, Lchat/ola/vn/mediastore/a;->e:Z

    invoke-virtual {p0, p1}, Lchat/ola/vn/mediastore/a;->a(Z)V

    iget-object p1, p0, Lchat/ola/vn/mediastore/a;->d:Landroid/view/View;

    instance-of p1, p1, Landroid/widget/ImageView;

    if-eqz p1, :cond_1

    iget p1, p0, Lchat/ola/vn/mediastore/a;->b:I

    if-lez p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/mediastore/a;->d:Landroid/view/View;

    check-cast p1, Landroid/widget/ImageView;

    iget v0, p0, Lchat/ola/vn/mediastore/a;->b:I

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setImageResource(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method public a(Landroid/view/View;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/mediastore/a;->d:Landroid/view/View;

    if-eqz v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    iget v0, p0, Lchat/ola/vn/mediastore/a;->a:I

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/mediastore/a;->d:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/mediastore/a;->d:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/mediastore/a;->c:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/mediastore/a;->d:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/mediastore/a;->f:Landroid/view/View$OnClickListener;

    invoke-virtual {p1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-boolean p1, p0, Lchat/ola/vn/mediastore/a;->e:Z

    invoke-virtual {p0, p1}, Lchat/ola/vn/mediastore/a;->a(Z)V

    iget-object p1, p0, Lchat/ola/vn/mediastore/a;->d:Landroid/view/View;

    instance-of p1, p1, Landroid/widget/ImageView;

    if-eqz p1, :cond_1

    iget p1, p0, Lchat/ola/vn/mediastore/a;->b:I

    if-lez p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/mediastore/a;->d:Landroid/view/View;

    check-cast p1, Landroid/widget/ImageView;

    iget v0, p0, Lchat/ola/vn/mediastore/a;->b:I

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setImageResource(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    return-void
.end method

.method public a(Z)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/mediastore/a;->d:Landroid/view/View;

    if-eqz v0, :cond_1

    if-eqz p1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/mediastore/a;->d:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/mediastore/a;->d:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_1
    :goto_0
    iput-boolean p1, p0, Lchat/ola/vn/mediastore/a;->e:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
