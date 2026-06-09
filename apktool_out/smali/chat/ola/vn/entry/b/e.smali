.class public Lchat/ola/vn/entry/b/e;
.super Lchat/ola/vn/entry/b/f;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private t:Landroid/view/View;

.field private u:Landroid/widget/TextView;

.field private v:Landroid/widget/TextView;

.field private w:Landroid/widget/ProgressBar;


# direct methods
.method public constructor <init>(Landroid/view/View;I)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/entry/b/f;-><init>(Landroid/view/View;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/e;->q:Landroid/view/ViewStub;

    invoke-virtual {v0, p2}, Landroid/view/ViewStub;->setLayoutResource(I)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/e;->q:Landroid/view/ViewStub;

    invoke-virtual {p2}, Landroid/view/ViewStub;->inflate()Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/entry/b/e;->q:Landroid/view/ViewStub;

    const/4 v0, 0x0

    invoke-virtual {p2, v0}, Landroid/view/ViewStub;->setVisibility(I)V

    const p2, 0x7f0904cc

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ProgressBar;

    iput-object p2, p0, Lchat/ola/vn/entry/b/e;->w:Landroid/widget/ProgressBar;

    const p2, 0x7f090489

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/entry/b/e;->t:Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/entry/b/e;->t:Landroid/view/View;

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f090487

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/e;->u:Landroid/widget/TextView;

    const p2, 0x7f090488

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/entry/b/e;->v:Landroid/widget/TextView;

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/e;->i:Lcom/mg/ola/common/widget/OlaTextView;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Lcom/mg/ola/common/widget/OlaTextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/e;->d:Landroid/view/View;

    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const p2, 0x7f07013c

    invoke-virtual {p1, p2}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p1

    iput p1, p0, Lchat/ola/vn/entry/b/e;->e:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;)V
    .locals 2

    :try_start_0
    invoke-super {p0, p1, p2, p3}, Lchat/ola/vn/entry/b/f;->a(Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;)V

    check-cast p1, Lchat/ola/vn/message/t;

    iget-object p2, p0, Lchat/ola/vn/entry/b/e;->t:Landroid/view/View;

    invoke-virtual {p2, p1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/e;->w:Landroid/widget/ProgressBar;

    iget-short p3, p1, Lchat/ola/vn/message/t;->z:S

    invoke-virtual {p2, p3}, Landroid/widget/ProgressBar;->setMax(I)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/e;->w:Landroid/widget/ProgressBar;

    iget-short p3, p1, Lchat/ola/vn/message/t;->A:S

    invoke-virtual {p2, p3}, Landroid/widget/ProgressBar;->setProgress(I)V

    iget-short p2, p1, Lchat/ola/vn/message/t;->A:S

    const/4 p3, 0x0

    if-lez p2, :cond_1

    iget-object p2, p0, Lchat/ola/vn/entry/b/e;->v:Landroid/widget/TextView;

    invoke-virtual {p2, p3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/e;->u:Landroid/widget/TextView;

    invoke-virtual {p2, p3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/e;->w:Landroid/widget/ProgressBar;

    invoke-virtual {p2, p3}, Landroid/widget/ProgressBar;->setVisibility(I)V

    iget-short p2, p1, Lchat/ola/vn/message/t;->A:S

    const/4 p3, 0x1

    if-le p2, p3, :cond_0

    iget-object p2, p0, Lchat/ola/vn/entry/b/e;->u:Landroid/widget/TextView;

    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    iget-short p1, p1, Lchat/ola/vn/message/t;->A:S

    int-to-long v0, p1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, " "

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const p1, 0x7f0f0646

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :goto_0
    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/entry/b/e;->u:Landroid/widget/TextView;

    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    iget-short p1, p1, Lchat/ola/vn/message/t;->A:S

    int-to-long v0, p1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, " "

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const p1, 0x7f0f0645

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/entry/b/e;->v:Landroid/widget/TextView;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/e;->u:Landroid/widget/TextView;

    invoke-virtual {p1, p3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/e;->u:Landroid/widget/TextView;

    const p3, 0x7f0f0421

    invoke-virtual {p1, p3}, Landroid/widget/TextView;->setText(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/e;->w:Landroid/widget/ProgressBar;

    invoke-virtual {p1, p2}, Landroid/widget/ProgressBar;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 2

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const v1, 0x7f090489

    if-eq v0, v1, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/t;

    invoke-virtual {p1}, Lchat/ola/vn/message/t;->g()V

    invoke-virtual {p1}, Lchat/ola/vn/message/t;->C()S

    move-result v0

    if-lez v0, :cond_1

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    invoke-static {v0, p1}, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->a(Landroid/content/Context;Lchat/ola/vn/message/t;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method
