.class public Lchat/ola/vn/entry/b/ah;
.super Lchat/ola/vn/entry/b/f;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field protected t:Landroid/widget/ProgressBar;

.field protected u:Landroid/widget/ProgressBar;

.field protected v:Landroid/view/View;

.field protected w:Landroid/widget/TextView;

.field protected x:Landroid/widget/ImageView;

.field protected y:Landroid/view/View;

.field private z:Lchat/ola/vn/message/aa;


# direct methods
.method public constructor <init>(Landroid/view/View;I)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/entry/b/f;-><init>(Landroid/view/View;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->q:Landroid/view/ViewStub;

    invoke-virtual {v0, p2}, Landroid/view/ViewStub;->setLayoutResource(I)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/ah;->q:Landroid/view/ViewStub;

    invoke-virtual {p2}, Landroid/view/ViewStub;->inflate()Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/entry/b/ah;->q:Landroid/view/ViewStub;

    const/4 v0, 0x0

    invoke-virtual {p2, v0}, Landroid/view/ViewStub;->setVisibility(I)V

    const p2, 0x7f0905fe

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ProgressBar;

    iput-object p2, p0, Lchat/ola/vn/entry/b/ah;->t:Landroid/widget/ProgressBar;

    const p2, 0x7f09048d

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ProgressBar;

    iput-object p2, p0, Lchat/ola/vn/entry/b/ah;->u:Landroid/widget/ProgressBar;

    iget-object p2, p0, Lchat/ola/vn/entry/b/ah;->t:Landroid/widget/ProgressBar;

    invoke-virtual {p2, v0}, Landroid/widget/ProgressBar;->setProgress(I)V

    const p2, 0x7f0905ff

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/ah;->w:Landroid/widget/TextView;

    const p2, 0x7f090602

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ImageView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/ah;->x:Landroid/widget/ImageView;

    const p2, 0x7f090601

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/entry/b/ah;->y:Landroid/view/View;

    const p2, 0x7f0905fd

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/entry/b/ah;->v:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/entry/b/ah;->v:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/ah;->i:Lcom/mg/ola/common/widget/OlaTextView;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Lcom/mg/ola/common/widget/OlaTextView;->setVisibility(I)V

    iput v0, p0, Lchat/ola/vn/entry/b/ah;->e:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private a(Lchat/ola/vn/message/aa;)V
    .locals 1

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    invoke-static {v0, p1}, Lchat/ola/vn/service/OlaVoiceChatService;->a(Landroid/content/Context;Lchat/ola/vn/message/aa;)V

    return-void
.end method

.method private b(Lchat/ola/vn/message/aa;)V
    .locals 0

    invoke-static {p1}, Lchat/ola/vn/service/OlaVoiceChatService;->a(Lchat/ola/vn/message/aa;)V

    return-void
.end method

.method private g()V
    .locals 9

    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->z:Lchat/ola/vn/message/aa;

    iput-object p0, v0, Lchat/ola/vn/message/aa;->C:Lchat/ola/vn/entry/b/ah;

    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->v:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/entry/b/ah;->z:Lchat/ola/vn/message/aa;

    invoke-virtual {v0, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->z:Lchat/ola/vn/message/aa;

    invoke-virtual {v0}, Lchat/ola/vn/message/aa;->d()B

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->t:Landroid/widget/ProgressBar;

    iget-object v1, p0, Lchat/ola/vn/entry/b/ah;->d:Landroid/view/View;

    invoke-virtual {v1}, Landroid/view/View;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x7f0807bf

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ProgressBar;->setProgressDrawable(Landroid/graphics/drawable/Drawable;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->z:Lchat/ola/vn/message/aa;

    invoke-virtual {v0}, Lchat/ola/vn/message/aa;->D()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->x:Landroid/widget/ImageView;

    const v1, 0x7f08075f

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->x:Landroid/widget/ImageView;

    const v1, 0x7f080762

    goto :goto_0

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->y:Landroid/view/View;

    const-string v1, "#8f8f8f"

    invoke-static {v1}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundColor(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->w:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->g:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->w:Landroid/widget/TextView;

    const v1, 0x7f0807be

    :goto_2
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setBackgroundResource(I)V

    goto :goto_5

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->t:Landroid/widget/ProgressBar;

    iget-object v1, p0, Lchat/ola/vn/entry/b/ah;->d:Landroid/view/View;

    invoke-virtual {v1}, Landroid/view/View;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x7f08081b

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ProgressBar;->setProgressDrawable(Landroid/graphics/drawable/Drawable;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->z:Lchat/ola/vn/message/aa;

    invoke-virtual {v0}, Lchat/ola/vn/message/aa;->D()Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->x:Landroid/widget/ImageView;

    const v1, 0x7f08075e

    :goto_3
    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    goto :goto_4

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->x:Landroid/widget/ImageView;

    const v1, 0x7f080761

    goto :goto_3

    :goto_4
    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->y:Landroid/view/View;

    sget v1, Lchat/ola/vn/f;->g:I

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundColor(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->w:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->h:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->w:Landroid/widget/TextView;

    const v1, 0x7f08081a

    goto :goto_2

    :goto_5
    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->z:Lchat/ola/vn/message/aa;

    iget-object v0, v0, Lchat/ola/vn/message/aa;->A:Ljava/lang/Long;

    const-wide/16 v1, 0x0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->z:Lchat/ola/vn/message/aa;

    iget-object v0, v0, Lchat/ola/vn/message/aa;->A:Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v3

    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->t:Landroid/widget/ProgressBar;

    long-to-int v5, v3

    invoke-virtual {v0, v5}, Landroid/widget/ProgressBar;->setMax(I)V

    goto :goto_6

    :cond_3
    move-wide v3, v1

    :goto_6
    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->z:Lchat/ola/vn/message/aa;

    iget-object v0, v0, Lchat/ola/vn/message/aa;->B:Ljava/lang/Long;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->z:Lchat/ola/vn/message/aa;

    iget-object v0, v0, Lchat/ola/vn/message/aa;->B:Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v5

    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->t:Landroid/widget/ProgressBar;

    long-to-int v7, v5

    invoke-virtual {v0, v7}, Landroid/widget/ProgressBar;->setProgress(I)V

    goto :goto_7

    :cond_4
    move-wide v5, v1

    :goto_7
    const/4 v0, 0x0

    sub-long v7, v3, v5

    const-wide/16 v5, 0x3e8

    div-long/2addr v7, v5

    cmp-long v0, v3, v1

    if-lez v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->w:Landroid/widget/TextView;

    long-to-int v1, v7

    int-to-long v1, v1

    const-string v3, ":"

    const-string v4, ":"

    invoke-static {v1, v2, v3, v4}, Lcom/mg/ola/common/d/i;->a(JLjava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    :goto_8
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_9

    :cond_5
    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->w:Landroid/widget/TextView;

    const-string v1, "-:--"

    goto :goto_8

    :goto_9
    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->z:Lchat/ola/vn/message/aa;

    invoke-virtual {v0}, Lchat/ola/vn/message/aa;->E()Z

    move-result v0

    const/16 v1, 0x8

    const/4 v2, 0x0

    if-eqz v0, :cond_6

    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->u:Landroid/widget/ProgressBar;

    invoke-virtual {v0, v2}, Landroid/widget/ProgressBar;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->w:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    return-void

    :cond_6
    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->u:Landroid/widget/ProgressBar;

    invoke-virtual {v0, v1}, Landroid/widget/ProgressBar;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->w:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;)V
    .locals 0

    invoke-super {p0, p1, p2, p3}, Lchat/ola/vn/entry/b/f;->a(Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/ah;->z:Lchat/ola/vn/message/aa;

    if-eqz p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/entry/b/ah;->z:Lchat/ola/vn/message/aa;

    const/4 p3, 0x0

    iput-object p3, p2, Lchat/ola/vn/message/aa;->C:Lchat/ola/vn/entry/b/ah;

    :cond_0
    check-cast p1, Lchat/ola/vn/message/aa;

    iput-object p1, p0, Lchat/ola/vn/entry/b/ah;->z:Lchat/ola/vn/message/aa;

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ah;->g()V

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->z:Lchat/ola/vn/message/aa;

    invoke-virtual {v0}, Lchat/ola/vn/message/aa;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ah;->g()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public a(Ljava/lang/String;II)V
    .locals 0

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/entry/b/ah;->z:Lchat/ola/vn/message/aa;

    invoke-virtual {p2}, Lchat/ola/vn/message/aa;->a()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ah;->g()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/entry/b/ah;->z:Lchat/ola/vn/message/aa;

    invoke-virtual {p2}, Lchat/ola/vn/message/aa;->C()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ah;->g()V

    iget-object p1, p0, Lchat/ola/vn/entry/b/ah;->z:Lchat/ola/vn/message/aa;

    invoke-direct {p0, p1}, Lchat/ola/vn/entry/b/ah;->a(Lchat/ola/vn/message/aa;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->z:Lchat/ola/vn/message/aa;

    invoke-virtual {v0}, Lchat/ola/vn/message/aa;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ah;->g()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public b(Ljava/lang/String;II)V
    .locals 0

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/entry/b/ah;->z:Lchat/ola/vn/message/aa;

    invoke-virtual {p2}, Lchat/ola/vn/message/aa;->a()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ah;->g()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/entry/b/ah;->z:Lchat/ola/vn/message/aa;

    invoke-virtual {p2}, Lchat/ola/vn/message/aa;->a()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/entry/b/ah;->u:Landroid/widget/ProgressBar;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/widget/ProgressBar;->setVisibility(I)V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ah;->g()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public c(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->z:Lchat/ola/vn/message/aa;

    invoke-virtual {v0}, Lchat/ola/vn/message/aa;->C()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ah;->g()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public c(Ljava/lang/String;II)V
    .locals 0

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/entry/b/ah;->z:Lchat/ola/vn/message/aa;

    invoke-virtual {p2}, Lchat/ola/vn/message/aa;->a()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ah;->g()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public d(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->z:Lchat/ola/vn/message/aa;

    invoke-virtual {v0}, Lchat/ola/vn/message/aa;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/entry/b/ah;->u:Landroid/widget/ProgressBar;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/ProgressBar;->setVisibility(I)V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ah;->g()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public d(Ljava/lang/String;II)V
    .locals 0

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/entry/b/ah;->z:Lchat/ola/vn/message/aa;

    invoke-virtual {p2}, Lchat/ola/vn/message/aa;->a()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/entry/b/ah;->u:Landroid/widget/ProgressBar;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/widget/ProgressBar;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method protected e()V
    .locals 5

    invoke-super {p0}, Lchat/ola/vn/entry/b/f;->e()V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->k:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundResource(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->k:Landroid/view/View;

    iget v1, p0, Lchat/ola/vn/entry/b/ah;->e:I

    iget v2, p0, Lchat/ola/vn/entry/b/ah;->e:I

    iget v3, p0, Lchat/ola/vn/entry/b/ah;->e:I

    iget v4, p0, Lchat/ola/vn/entry/b/ah;->e:I

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/view/View;->setPadding(IIII)V

    return-void
.end method

.method public e(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ah;->z:Lchat/ola/vn/message/aa;

    invoke-virtual {v0}, Lchat/ola/vn/message/aa;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/entry/b/ah;->u:Landroid/widget/ProgressBar;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/ProgressBar;->setVisibility(I)V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ah;->g()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 2

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const v1, 0x7f0905fd

    if-eq v0, v1, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/aa;

    invoke-virtual {p1}, Lchat/ola/vn/message/aa;->g()V

    invoke-virtual {p1}, Lchat/ola/vn/message/aa;->D()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-direct {p0, p1}, Lchat/ola/vn/entry/b/ah;->b(Lchat/ola/vn/message/aa;)V

    return-void

    :cond_1
    invoke-virtual {p1}, Lchat/ola/vn/message/aa;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-virtual {p1}, Lchat/ola/vn/message/aa;->C()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    invoke-virtual {p1}, Lchat/ola/vn/message/aa;->F()V

    return-void

    :cond_2
    invoke-direct {p0, p1}, Lchat/ola/vn/entry/b/ah;->a(Lchat/ola/vn/message/aa;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
