.class public Lchat/ola/vn/i/c;
.super Lchat/ola/vn/i/n;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private a:Lcom/mg/ola/common/widget/ProgressCircleView;

.field private b:Landroid/widget/TextView;

.field private c:Landroid/widget/Button;

.field private d:Landroid/widget/Button;

.field private e:J

.field private f:Landroid/content/DialogInterface$OnClickListener;

.field private g:Landroid/view/View;

.field private h:Landroid/os/CountDownTimer;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 2

    invoke-direct {p0, p1}, Lchat/ola/vn/i/n;-><init>(Landroid/content/Context;)V

    const-wide/16 v0, 0x64

    iput-wide v0, p0, Lchat/ola/vn/i/c;->e:J

    const/4 v0, 0x1

    :try_start_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/i/c;->requestWindowFeature(I)Z

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lchat/ola/vn/i/c;->setCanceledOnTouchOutside(Z)V

    const v0, 0x7f0b0099

    invoke-virtual {p0, v0}, Lchat/ola/vn/i/c;->setContentView(I)V

    invoke-virtual {p0}, Lchat/ola/vn/i/c;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    const/4 v1, -0x2

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->height:I

    invoke-virtual {p0}, Lchat/ola/vn/i/c;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const v1, 0x7f0700db

    invoke-virtual {p1, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p1

    iput p1, v0, Landroid/view/WindowManager$LayoutParams;->width:I

    const p1, 0x7f0903e9

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/c;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lcom/mg/ola/common/widget/ProgressCircleView;

    iput-object p1, p0, Lchat/ola/vn/i/c;->a:Lcom/mg/ola/common/widget/ProgressCircleView;

    iget-object p1, p0, Lchat/ola/vn/i/c;->a:Lcom/mg/ola/common/widget/ProgressCircleView;

    const/16 v0, 0x32

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/widget/ProgressCircleView;->setRadius(I)V

    iget-object p1, p0, Lchat/ola/vn/i/c;->a:Lcom/mg/ola/common/widget/ProgressCircleView;

    const/high16 v0, 0x41000000    # 8.0f

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/widget/ProgressCircleView;->setStrokeWidth(F)V

    iget-object p1, p0, Lchat/ola/vn/i/c;->a:Lcom/mg/ola/common/widget/ProgressCircleView;

    const-string v0, "#379cf1"

    invoke-static {v0}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v0

    const-string v1, "#40379cf1"

    invoke-static {v1}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {p1, v0, v1}, Lcom/mg/ola/common/widget/ProgressCircleView;->a(II)V

    const p1, 0x7f0902e6

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/c;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/i/c;->g:Landroid/view/View;

    const p1, 0x7f09055e

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/c;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/i/c;->b:Landroid/widget/TextView;

    const p1, 0x7f090137

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/c;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/i/c;->c:Landroid/widget/Button;

    const p1, 0x7f090138

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/c;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/i/c;->d:Landroid/widget/Button;

    iget-object p1, p0, Lchat/ola/vn/i/c;->g:Landroid/view/View;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/i/c;->c:Landroid/widget/Button;

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/i/c;->d:Landroid/widget/Button;

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/i/c;->c:Landroid/widget/Button;

    invoke-virtual {p1, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/i/c;->d:Landroid/widget/Button;

    invoke-virtual {p1, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/i/c;)Lcom/mg/ola/common/widget/ProgressCircleView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/i/c;->a:Lcom/mg/ola/common/widget/ProgressCircleView;

    return-object p0
.end method


# virtual methods
.method public a()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/i/c;->h:Landroid/os/CountDownTimer;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/i/c;->h:Landroid/os/CountDownTimer;

    invoke-virtual {v0}, Landroid/os/CountDownTimer;->cancel()V

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/i/c;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(I)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/i/c;->b:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(JLjava/lang/Runnable;)V
    .locals 12

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/i/c;->a:Lcom/mg/ola/common/widget/ProgressCircleView;

    const-wide/16 v1, 0x0

    invoke-virtual {v0, v1, v2}, Lcom/mg/ola/common/widget/ProgressCircleView;->setProgress(J)V

    new-instance v0, Lchat/ola/vn/i/c$1;

    const-wide/16 v3, 0x64

    div-long v5, p1, v3

    cmp-long v7, v5, v1

    if-nez v7, :cond_0

    move-wide v7, p1

    goto :goto_0

    :cond_0
    div-long v1, p1, v3

    move-wide v7, v1

    :goto_0
    move-object v3, v0

    move-object v4, p0

    move-wide v5, p1

    move-wide v9, p1

    move-object v11, p3

    invoke-direct/range {v3 .. v11}, Lchat/ola/vn/i/c$1;-><init>(Lchat/ola/vn/i/c;JJJLjava/lang/Runnable;)V

    iput-object v0, p0, Lchat/ola/vn/i/c;->h:Landroid/os/CountDownTimer;

    iget-object p1, p0, Lchat/ola/vn/i/c;->h:Landroid/os/CountDownTimer;

    invoke-virtual {p1}, Landroid/os/CountDownTimer;->start()Landroid/os/CountDownTimer;

    invoke-virtual {p0}, Lchat/ola/vn/i/c;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    invoke-virtual {p0}, Lchat/ola/vn/i/c;->isShowing()Z

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/i/c;->h:Landroid/os/CountDownTimer;

    if-eqz p1, :cond_1

    invoke-virtual {p0}, Lchat/ola/vn/i/c;->dismiss()V

    :cond_1
    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/i/c;->b:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/i/c;->f:Landroid/content/DialogInterface$OnClickListener;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    packed-switch p1, :pswitch_data_0

    goto :goto_1

    :pswitch_0
    iget-object p1, p0, Lchat/ola/vn/i/c;->f:Landroid/content/DialogInterface$OnClickListener;

    const/4 v0, 0x1

    goto :goto_0

    :pswitch_1
    iget-object p1, p0, Lchat/ola/vn/i/c;->f:Landroid/content/DialogInterface$OnClickListener;

    const/4 v0, 0x0

    :goto_0
    invoke-interface {p1, p0, v0}, Landroid/content/DialogInterface$OnClickListener;->onClick(Landroid/content/DialogInterface;I)V

    :goto_1
    invoke-virtual {p0}, Lchat/ola/vn/i/c;->dismiss()V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x7f090137
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
