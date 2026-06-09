.class Lchat/ola/vn/b/y$a;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/b/y;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/b/y;

.field private b:Lchat/ola/vn/view/OlaCachedImageView;

.field private c:Landroid/widget/ProgressBar;

.field private d:Landroid/widget/TextView;

.field private e:Landroid/widget/TextView;

.field private f:Landroid/widget/TextView;

.field private g:Landroid/widget/TextView;

.field private h:Landroid/view/View;

.field private i:Landroid/view/View;

.field private j:Landroid/view/View;

.field private k:Landroid/widget/Button;

.field private l:Landroid/widget/TextView;

.field private m:Landroid/widget/TextView;

.field private n:Lchat/ola/vn/entity/s;


# direct methods
.method constructor <init>(Lchat/ola/vn/b/y;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/y$a;->a:Lchat/ola/vn/b/y;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const p1, 0x7f0902ca

    :try_start_0
    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/b/y$a;->f:Landroid/widget/TextView;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const p1, 0x7f090432

    :try_start_1
    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/b/y$a;->d:Landroid/widget/TextView;

    const p1, 0x7f090431

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/b/y$a;->e:Landroid/widget/TextView;

    const p1, 0x7f090430

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/b/y$a;->g:Landroid/widget/TextView;

    const p1, 0x7f09042b

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/b/y$a;->b:Lchat/ola/vn/view/OlaCachedImageView;

    const p1, 0x7f09042d

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ProgressBar;

    iput-object p1, p0, Lchat/ola/vn/b/y$a;->c:Landroid/widget/ProgressBar;

    const p1, 0x7f09030a

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/y$a;->h:Landroid/view/View;

    const p1, 0x7f09042f

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/y$a;->i:Landroid/view/View;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    const p1, 0x7f090605

    :try_start_2
    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/y$a;->j:Landroid/view/View;

    const p1, 0x7f090604

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/b/y$a;->k:Landroid/widget/Button;

    const p1, 0x7f090606

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/b/y$a;->l:Landroid/widget/TextView;

    const p1, 0x7f090607

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/b/y$a;->m:Landroid/widget/TextView;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/s;Lchat/ola/vn/entity/s;Lchat/ola/vn/entity/s;)V
    .locals 4

    iput-object p1, p0, Lchat/ola/vn/b/y$a;->n:Lchat/ola/vn/entity/s;

    iget-object p1, p0, Lchat/ola/vn/b/y$a;->n:Lchat/ola/vn/entity/s;

    invoke-virtual {p1}, Lchat/ola/vn/entity/s;->h()B

    move-result p1

    const/4 p2, 0x2

    if-ne p1, p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/b/y$a;->f:Landroid/widget/TextView;

    iget-object p2, p0, Lchat/ola/vn/b/y$a;->n:Lchat/ola/vn/entity/s;

    invoke-virtual {p2}, Lchat/ola/vn/entity/s;->d()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_0
    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/b/y$a;->i:Landroid/view/View;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/b/y$a;->n:Lchat/ola/vn/entity/s;

    invoke-virtual {p1}, Lchat/ola/vn/entity/s;->c()J

    move-result-wide v0

    sget-object p1, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {p1}, Lchat/ola/vn/r/a/f;->k()J

    move-result-wide v2

    cmp-long p1, v0, v2

    if-nez p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/b/y$a;->i:Landroid/view/View;

    sget v0, Lchat/ola/vn/f;->I:I

    :goto_0
    invoke-virtual {p1, v0}, Landroid/view/View;->setBackgroundColor(I)V

    goto :goto_1

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/b/y$a;->i:Landroid/view/View;

    sget v0, Lchat/ola/vn/f;->d:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_2
    :goto_1
    const/4 p1, 0x0

    if-eqz p3, :cond_3

    invoke-virtual {p3}, Lchat/ola/vn/entity/s;->h()B

    move-result p3

    if-eq p3, p2, :cond_3

    iget-object p2, p0, Lchat/ola/vn/b/y$a;->h:Landroid/view/View;

    invoke-virtual {p2, p1}, Landroid/view/View;->setVisibility(I)V

    goto :goto_2

    :cond_3
    iget-object p2, p0, Lchat/ola/vn/b/y$a;->h:Landroid/view/View;

    const/4 p3, 0x4

    invoke-virtual {p2, p3}, Landroid/view/View;->setVisibility(I)V

    :goto_2
    iget-object p2, p0, Lchat/ola/vn/b/y$a;->n:Lchat/ola/vn/entity/s;

    invoke-virtual {p2}, Lchat/ola/vn/entity/s;->h()B

    move-result p2

    const/4 p3, 0x1

    const/16 v0, 0x8

    if-ne p2, p3, :cond_4

    iget-object p2, p0, Lchat/ola/vn/b/y$a;->c:Landroid/widget/ProgressBar;

    invoke-virtual {p2, v0}, Landroid/widget/ProgressBar;->setVisibility(I)V

    iget-object p2, p0, Lchat/ola/vn/b/y$a;->b:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p2, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setBackgroundResource(I)V

    iget-object p1, p0, Lchat/ola/vn/b/y$a;->b:Lchat/ola/vn/view/OlaCachedImageView;

    const p2, 0x7f080794

    invoke-virtual {p1, p2}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/b/y$a;->d:Landroid/widget/TextView;

    const p2, 0x7f0f0423

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(I)V

    iget-object p1, p0, Lchat/ola/vn/b/y$a;->e:Landroid/widget/TextView;

    const p2, 0x7f0f0424

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(I)V

    :goto_3
    iget-object p1, p0, Lchat/ola/vn/b/y$a;->g:Landroid/widget/TextView;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    return-void

    :cond_4
    iget-object p2, p0, Lchat/ola/vn/b/y$a;->n:Lchat/ola/vn/entity/s;

    invoke-virtual {p2}, Lchat/ola/vn/entity/s;->h()B

    move-result p2

    const/4 p3, 0x6

    const/4 v1, 0x3

    if-ne p2, p3, :cond_9

    :try_start_1
    iget-object p2, p0, Lchat/ola/vn/b/y$a;->j:Landroid/view/View;

    if-eqz p2, :cond_5

    iget-object p2, p0, Lchat/ola/vn/b/y$a;->j:Landroid/view/View;

    invoke-virtual {p2, v0}, Landroid/view/View;->setVisibility(I)V

    :cond_5
    sget-object p2, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-short p2, p2, Lchat/ola/vn/entity/ag;->u:S

    if-nez p2, :cond_6

    iget-object p2, p0, Lchat/ola/vn/b/y$a;->j:Landroid/view/View;

    invoke-virtual {p2, p1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/b/y$a;->j:Landroid/view/View;

    const-string p2, "0"

    invoke-virtual {p1, p2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/b/y$a;->k:Landroid/widget/Button;

    const p2, 0x7f0f0444

    invoke-virtual {p1, p2}, Landroid/widget/Button;->setText(I)V

    iget-object p1, p0, Lchat/ola/vn/b/y$a;->l:Landroid/widget/TextView;

    const p2, 0x7f0f0329

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(I)V

    iget-object p1, p0, Lchat/ola/vn/b/y$a;->m:Landroid/widget/TextView;

    const p2, 0x7f0f032b

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(I)V

    goto :goto_4

    :cond_6
    sget-object p2, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget p2, p2, Lchat/ola/vn/entity/ag;->q:I

    if-lez p2, :cond_7

    sget-object p2, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget p2, p2, Lchat/ola/vn/entity/ag;->q:I

    if-ge p2, v1, :cond_7

    iget-object p2, p0, Lchat/ola/vn/b/y$a;->j:Landroid/view/View;

    invoke-virtual {p2, p1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/b/y$a;->j:Landroid/view/View;

    const-string p2, "1"

    invoke-virtual {p1, p2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/b/y$a;->k:Landroid/widget/Button;

    const p2, 0x7f0f04ea

    invoke-virtual {p1, p2}, Landroid/widget/Button;->setText(I)V

    iget-object p1, p0, Lchat/ola/vn/b/y$a;->l:Landroid/widget/TextView;

    const p2, 0x7f0f0246

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(I)V

    iget-object p1, p0, Lchat/ola/vn/b/y$a;->m:Landroid/widget/TextView;

    const p2, 0x7f0f0247

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(I)V

    goto :goto_4

    :cond_7
    sget-object p2, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-boolean p2, p2, Lchat/ola/vn/entity/ag;->x:Z

    if-nez p2, :cond_8

    iget-object p2, p0, Lchat/ola/vn/b/y$a;->j:Landroid/view/View;

    invoke-virtual {p2, p1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/b/y$a;->j:Landroid/view/View;

    const-string p2, "2"

    invoke-virtual {p1, p2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/b/y$a;->k:Landroid/widget/Button;

    const p2, 0x7f0f068c

    invoke-virtual {p1, p2}, Landroid/widget/Button;->setText(I)V

    iget-object p1, p0, Lchat/ola/vn/b/y$a;->l:Landroid/widget/TextView;

    const p2, 0x7f0f02e3

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(I)V

    iget-object p1, p0, Lchat/ola/vn/b/y$a;->m:Landroid/widget/TextView;

    const p2, 0x7f0f03a7

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(I)V

    :cond_8
    :goto_4
    iget-object p1, p0, Lchat/ola/vn/b/y$a;->j:Landroid/view/View;

    new-instance p2, Lchat/ola/vn/b/y$a$1;

    invoke-direct {p2, p0}, Lchat/ola/vn/b/y$a$1;-><init>(Lchat/ola/vn/b/y$a;)V

    invoke-virtual {p1, p2}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :catch_1
    :try_start_2
    iget-object p1, p0, Lchat/ola/vn/b/y$a;->j:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    return-void

    :cond_9
    iget-object p2, p0, Lchat/ola/vn/b/y$a;->d:Landroid/widget/TextView;

    iget-object p3, p0, Lchat/ola/vn/b/y$a;->n:Lchat/ola/vn/entity/s;

    invoke-virtual {p3}, Lchat/ola/vn/entity/s;->d()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p2, p0, Lchat/ola/vn/b/y$a;->e:Landroid/widget/TextView;

    iget-object p3, p0, Lchat/ola/vn/b/y$a;->n:Lchat/ola/vn/entity/s;

    invoke-virtual {p3}, Lchat/ola/vn/entity/s;->f()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p2, p0, Lchat/ola/vn/b/y$a;->n:Lchat/ola/vn/entity/s;

    invoke-virtual {p2}, Lchat/ola/vn/entity/s;->h()B

    move-result p2

    const/4 p3, 0x5

    if-ne p2, p3, :cond_a

    iget-object p2, p0, Lchat/ola/vn/b/y$a;->c:Landroid/widget/ProgressBar;

    invoke-virtual {p2, v0}, Landroid/widget/ProgressBar;->setVisibility(I)V

    iget-object p2, p0, Lchat/ola/vn/b/y$a;->b:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p2, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setBackgroundResource(I)V

    iget-object p1, p0, Lchat/ola/vn/b/y$a;->b:Lchat/ola/vn/view/OlaCachedImageView;

    const p2, 0x7f080627

    invoke-virtual {p1, p2}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    goto/16 :goto_3

    :cond_a
    iget-object p2, p0, Lchat/ola/vn/b/y$a;->n:Lchat/ola/vn/entity/s;

    invoke-virtual {p2}, Lchat/ola/vn/entity/s;->h()B

    move-result p2

    if-ne p2, v1, :cond_b

    iget-object p2, p0, Lchat/ola/vn/b/y$a;->b:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p2, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setBackgroundResource(I)V

    iget-object p1, p0, Lchat/ola/vn/b/y$a;->g:Landroid/widget/TextView;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_7

    :cond_b
    iget-object p2, p0, Lchat/ola/vn/b/y$a;->b:Lchat/ola/vn/view/OlaCachedImageView;

    const p3, 0x7f0800d3

    invoke-virtual {p2, p3}, Lchat/ola/vn/view/OlaCachedImageView;->setBackgroundResource(I)V

    iget-object p2, p0, Lchat/ola/vn/b/y$a;->g:Landroid/widget/TextView;

    invoke-virtual {p2, p1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/b/y$a;->n:Lchat/ola/vn/entity/s;

    invoke-virtual {p1}, Lchat/ola/vn/entity/s;->a()J

    move-result-wide p1

    const-wide/16 v0, 0xc8

    cmp-long p3, p1, v0

    if-ltz p3, :cond_c

    iget-object p1, p0, Lchat/ola/vn/b/y$a;->g:Landroid/widget/TextView;

    sget p2, Lchat/ola/vn/f;->L:I

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object p1, p0, Lchat/ola/vn/b/y$a;->g:Landroid/widget/TextView;

    const-string p2, "200+"

    :goto_5
    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_7

    :cond_c
    iget-object p1, p0, Lchat/ola/vn/b/y$a;->n:Lchat/ola/vn/entity/s;

    invoke-virtual {p1}, Lchat/ola/vn/entity/s;->a()J

    move-result-wide p1

    const-wide/16 v0, 0x64

    cmp-long p3, p1, v0

    if-ltz p3, :cond_d

    iget-object p1, p0, Lchat/ola/vn/b/y$a;->g:Landroid/widget/TextView;

    sget p2, Lchat/ola/vn/f;->z:I

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object p1, p0, Lchat/ola/vn/b/y$a;->g:Landroid/widget/TextView;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    :goto_6
    const-string p3, ""

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p3, p0, Lchat/ola/vn/b/y$a;->n:Lchat/ola/vn/entity/s;

    invoke-virtual {p3}, Lchat/ola/vn/entity/s;->a()J

    move-result-wide v0

    invoke-virtual {p2, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    goto :goto_5

    :cond_d
    iget-object p1, p0, Lchat/ola/vn/b/y$a;->g:Landroid/widget/TextView;

    sget p2, Lchat/ola/vn/f;->A:I

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object p1, p0, Lchat/ola/vn/b/y$a;->g:Landroid/widget/TextView;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    goto :goto_6

    :goto_7
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/b/y$a;->n:Lchat/ola/vn/entity/s;

    invoke-virtual {p2}, Lchat/ola/vn/entity/s;->g()Ljava/lang/String;

    move-result-object p2

    iget-object p3, p0, Lchat/ola/vn/b/y$a;->b:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v0, p0, Lchat/ola/vn/b/y$a;->c:Landroid/widget/ProgressBar;

    invoke-virtual {p1, p2, p3, v0}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;)V

    :catch_2
    return-void
.end method
