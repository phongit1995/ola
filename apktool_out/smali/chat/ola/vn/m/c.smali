.class public abstract Lchat/ola/vn/m/c;
.super Lchat/ola/vn/m/p;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/m/p<",
        "Lchat/ola/vn/m/j;",
        ">;"
    }
.end annotation


# instance fields
.field protected a:Landroid/widget/TextView;

.field protected b:Lchat/ola/vn/entity/t;

.field private d:Landroid/view/View;

.field private e:Landroid/widget/Button;

.field private f:Landroid/widget/TextView;

.field private g:Landroid/widget/TextView;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/p;-><init>()V

    return-void
.end method


# virtual methods
.method protected a(Landroid/view/LayoutInflater;)Landroid/view/View;
    .locals 2

    const v0, 0x7f0b0119

    const/4 v1, 0x0

    :try_start_0
    invoke-virtual {p1, v0, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    const v0, 0x7f09036c

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/m/c;->a:Landroid/widget/TextView;

    const v0, 0x7f090605

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/m/c;->d:Landroid/view/View;

    const v0, 0x7f090604

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lchat/ola/vn/m/c;->e:Landroid/widget/Button;

    const v0, 0x7f090606

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/m/c;->f:Landroid/widget/TextView;

    const v0, 0x7f090607

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/m/c;->g:Landroid/widget/TextView;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    return-object v1
.end method

.method public a(Lchat/ola/vn/entity/t;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/c;->b:Lchat/ola/vn/entity/t;

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

.method public d_()V
    .locals 0

    return-void
.end method

.method public e()V
    .locals 4

    invoke-virtual {p0}, Lchat/ola/vn/m/c;->e_()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    const/16 v2, 0x8

    const/4 v3, 0x0

    if-eqz v1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/c;->a:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/m/c;->a:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/m/c;->a:Landroid/widget/TextView;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_0
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/c;->d:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    sget-object v0, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-short v0, v0, Lchat/ola/vn/entity/ag;->u:S

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/m/c;->d:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/m/c;->d:Landroid/view/View;

    const-string v1, "0"

    invoke-virtual {v0, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/m/c;->e:Landroid/widget/Button;

    const v1, 0x7f0f0444

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/m/c;->f:Landroid/widget/TextView;

    const v1, 0x7f0f0329

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/m/c;->g:Landroid/widget/TextView;

    const v1, 0x7f0f032b

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    goto :goto_1

    :cond_1
    sget-object v0, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget v0, v0, Lchat/ola/vn/entity/ag;->q:I

    if-lez v0, :cond_2

    sget-object v0, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget v0, v0, Lchat/ola/vn/entity/ag;->q:I

    const/4 v1, 0x3

    if-ge v0, v1, :cond_2

    iget-object v0, p0, Lchat/ola/vn/m/c;->d:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/m/c;->d:Landroid/view/View;

    const-string v1, "1"

    invoke-virtual {v0, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/m/c;->e:Landroid/widget/Button;

    const v1, 0x7f0f04ea

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/m/c;->f:Landroid/widget/TextView;

    const v1, 0x7f0f0246

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/m/c;->g:Landroid/widget/TextView;

    const v1, 0x7f0f0247

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    goto :goto_1

    :cond_2
    sget-object v0, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-boolean v0, v0, Lchat/ola/vn/entity/ag;->x:Z

    if-nez v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/m/c;->d:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/m/c;->d:Landroid/view/View;

    const-string v1, "2"

    invoke-virtual {v0, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/m/c;->e:Landroid/widget/Button;

    const v1, 0x7f0f068c

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/m/c;->f:Landroid/widget/TextView;

    const v1, 0x7f0f02e3

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/m/c;->g:Landroid/widget/TextView;

    const v1, 0x7f0f03a7

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    :cond_3
    :goto_1
    iget-object v0, p0, Lchat/ola/vn/m/c;->d:Landroid/view/View;

    new-instance v1, Lchat/ola/vn/m/c$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/m/c$1;-><init>(Lchat/ola/vn/m/c;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/m/c;->d:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method public e_()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/m/c;->b:Lchat/ola/vn/entity/t;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/c;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->p()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    const-string v0, ""

    return-object v0
.end method

.method public f()Lchat/ola/vn/m/j;
    .locals 1

    invoke-super {p0}, Lchat/ola/vn/m/p;->g()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_0

    invoke-static {}, Lchat/ola/vn/m/j;->c()Lchat/ola/vn/m/j;

    move-result-object v0

    return-object v0

    :cond_0
    invoke-super {p0}, Lchat/ola/vn/m/p;->g()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/m/j;

    return-object v0
.end method

.method public synthetic g()Ljava/lang/Object;
    .locals 1

    invoke-virtual {p0}, Lchat/ola/vn/m/c;->f()Lchat/ola/vn/m/j;

    move-result-object v0

    return-object v0
.end method
