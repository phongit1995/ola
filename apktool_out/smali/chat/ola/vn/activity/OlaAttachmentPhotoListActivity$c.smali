.class Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "c"
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

.field private b:Lchat/ola/vn/view/OlaCachedImageView;

.field private c:Landroid/view/View;

.field private d:Landroid/widget/TextView;

.field private e:Landroid/widget/ImageView;


# direct methods
.method public constructor <init>(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const p1, 0x7f0903ce

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;->b:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;->b:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0903cb

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageView;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;->e:Landroid/widget/ImageView;

    const p1, 0x7f0905e3

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;->c:Landroid/view/View;

    const p1, 0x7f0905e2

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;->d:Landroid/widget/TextView;

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;)V
    .locals 9

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;->b:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setTag(Ljava/lang/Object;)V

    iget-object v0, p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->d:Ljava/lang/String;

    const v1, 0x7f08071a

    const/4 v2, 0x2

    const/4 v3, 0x1

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/16 v6, 0x8

    if-eqz v0, :cond_2

    iget-short v7, p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->c:S

    if-ne v7, v3, :cond_0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;->c:Landroid/view/View;

    invoke-virtual {v1, v6}, Landroid/view/View;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;->b:Lchat/ola/vn/view/OlaCachedImageView;

    const/16 v3, 0x140

    invoke-virtual {v1, v0, v2, v3}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;I)V

    goto :goto_0

    :cond_0
    iget-short v0, p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->c:S

    if-ne v0, v2, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;->d:Landroid/widget/TextView;

    invoke-virtual {v0, v6}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;->c:Landroid/view/View;

    invoke-virtual {v0, v5}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;->b:Lchat/ola/vn/view/OlaCachedImageView;

    sget-object v2, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;->b:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;->c:Landroid/view/View;

    invoke-virtual {v0, v6}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;->b:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v4, v4}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    iget-short v0, p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->c:S

    if-ne v0, v3, :cond_3

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;->c:Landroid/view/View;

    invoke-virtual {v0, v6}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->e:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;->b:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v0, v2}, Lchat/ola/vn/c/t;->e(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    goto :goto_0

    :cond_3
    iget-short v0, p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->c:S

    if-ne v0, v2, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;->d:Landroid/widget/TextView;

    invoke-virtual {v0, v5}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;->d:Landroid/widget/TextView;

    iget-wide v2, p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->b:J

    const-wide/16 v7, 0x3e8

    div-long/2addr v2, v7

    const-string v4, ":"

    const-string v7, ":"

    invoke-static {v2, v3, v4, v7}, Lcom/mg/ola/common/d/i;->a(JLjava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;->c:Landroid/view/View;

    invoke-virtual {v0, v5}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->e:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;->b:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v2, v0, v3, v1}, Lchat/ola/vn/c/t;->c(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;I)V

    :goto_0
    invoke-static {}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->C()Z

    move-result v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;->e:Landroid/widget/ImageView;

    invoke-virtual {v0, v5}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-boolean p1, p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->f:Z

    if-eqz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;->e:Landroid/widget/ImageView;

    const v0, 0x7f0806b7

    :goto_1
    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setImageResource(I)V

    return-void

    :cond_4
    iget-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;->e:Landroid/widget/ImageView;

    const v0, 0x7f0806b8

    goto :goto_1

    :cond_5
    iget-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;->e:Landroid/widget/ImageView;

    invoke-virtual {p1, v6}, Landroid/widget/ImageView;->setVisibility(I)V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 4

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const v1, 0x7f0903ce

    if-eq v0, v1, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;

    invoke-static {}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->C()Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    iget-boolean v0, p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->f:Z

    xor-int/2addr v0, v1

    iput-boolean v0, p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->f:Z

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    invoke-static {v0, p1}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->a(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->b(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;)Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$d;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$d;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    return-void

    :cond_1
    :try_start_1
    invoke-static {}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->D()B

    move-result v0

    const/4 v2, 0x2

    if-nez v0, :cond_3

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iget-object v3, p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->d:Ljava/lang/String;

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-short v3, p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->c:S

    if-ne v3, v1, :cond_2

    invoke-static {}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->E()Lchat/ola/vn/view/g$e;

    move-result-object p1

    invoke-interface {p1, v0}, Lchat/ola/vn/view/g$e;->d(Ljava/util/List;)V

    goto :goto_0

    :cond_2
    iget-short p1, p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->c:S

    if-ne p1, v2, :cond_5

    invoke-static {}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->E()Lchat/ola/vn/view/g$e;

    move-result-object p1

    invoke-interface {p1, v0}, Lchat/ola/vn/view/g$e;->e(Ljava/util/List;)V

    goto :goto_0

    :cond_3
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iget-object v3, p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->e:Ljava/lang/String;

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-short v3, p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->c:S

    if-ne v3, v1, :cond_4

    invoke-static {}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->E()Lchat/ola/vn/view/g$e;

    move-result-object p1

    invoke-interface {p1, v0}, Lchat/ola/vn/view/g$e;->f(Ljava/util/List;)V

    goto :goto_0

    :cond_4
    iget-short p1, p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->c:S

    if-ne p1, v2, :cond_5

    invoke-static {}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->E()Lchat/ola/vn/view/g$e;

    move-result-object p1

    invoke-interface {p1, v0}, Lchat/ola/vn/view/g$e;->g(Ljava/util/List;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_5
    :goto_0
    :try_start_2
    iget-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    invoke-virtual {p1}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->finish()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method
