.class public Lchat/ola/vn/i/s;
.super Lchat/ola/vn/i/n;

# interfaces
.implements Landroid/content/DialogInterface$OnDismissListener;
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/i/s$a;
    }
.end annotation


# instance fields
.field private a:Landroid/widget/ImageView;

.field private b:Landroid/widget/ProgressBar;

.field private c:Landroid/widget/TextView;

.field private d:Landroid/widget/TextView;

.field private e:Landroid/widget/TextView;

.field private f:Landroid/widget/Button;

.field private g:Lchat/ola/vn/i/s$a;

.field private h:I

.field private k:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private l:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/u/p;",
            ">;"
        }
    .end annotation
.end field

.field private m:Landroid/os/Handler;


# direct methods
.method public constructor <init>(Landroid/content/Context;Lchat/ola/vn/i/s$a;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/i/n;-><init>(Landroid/content/Context;)V

    invoke-direct {p0, p1}, Lchat/ola/vn/i/s;->a(Landroid/content/Context;)V

    iput-object p2, p0, Lchat/ola/vn/i/s;->g:Lchat/ola/vn/i/s$a;

    new-instance p1, Landroid/os/Handler;

    invoke-direct {p1}, Landroid/os/Handler;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/i/s;->m:Landroid/os/Handler;

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/i/s;)Landroid/os/Handler;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/i/s;->m:Landroid/os/Handler;

    return-object p0
.end method

.method private a(JJ)V
    .locals 4

    const-wide/16 v0, 0x0

    cmp-long v2, p3, v0

    if-eqz v2, :cond_0

    const-wide/16 v0, 0x64

    mul-long v0, v0, p1

    :try_start_0
    div-long/2addr v0, p3

    long-to-int v0, v0

    iget-object v1, p0, Lchat/ola/vn/i/s;->c:Landroid/widget/TextView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, "%"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, p0, Lchat/ola/vn/i/s;->b:Landroid/widget/ProgressBar;

    const/16 v2, 0x64

    invoke-virtual {v1, v2}, Landroid/widget/ProgressBar;->setMax(I)V

    iget-object v1, p0, Lchat/ola/vn/i/s;->b:Landroid/widget/ProgressBar;

    invoke-virtual {v1, v0}, Landroid/widget/ProgressBar;->setProgress(I)V

    goto :goto_0

    :catch_0
    move-exception p1

    goto :goto_1

    :cond_0
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/i/s;->e:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Lchat/ola/vn/i/s;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2, p1, p2}, Landroid/text/format/Formatter;->formatShortFileSize(Landroid/content/Context;J)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "/"

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lchat/ola/vn/i/s;->getContext()Landroid/content/Context;

    move-result-object p1

    invoke-static {p1, p3, p4}, Landroid/text/format/Formatter;->formatShortFileSize(Landroid/content/Context;J)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/i/s;->d:Landroid/widget/TextView;

    invoke-virtual {p0}, Lchat/ola/vn/i/s;->getContext()Landroid/content/Context;

    move-result-object p2

    const p3, 0x7f0f032d

    const/4 p4, 0x1

    new-array p4, p4, [Ljava/lang/Object;

    const/4 v0, 0x0

    iget-object v1, p0, Lchat/ola/vn/i/s;->k:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    aput-object v1, p4, v0

    invoke-virtual {p2, p3, p4}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :goto_1
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private a(Landroid/content/Context;)V
    .locals 3

    invoke-super {p0, p0}, Lchat/ola/vn/i/n;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)V

    const v0, 0x7f0b01cc

    invoke-virtual {p0, v0}, Lchat/ola/vn/i/s;->setContentView(I)V

    invoke-virtual {p0}, Lchat/ola/vn/i/s;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x7f0700db

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v1

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->width:I

    const v0, 0x7f0902ae

    invoke-virtual {p0, v0}, Lchat/ola/vn/i/s;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lchat/ola/vn/i/s;->a:Landroid/widget/ImageView;

    const v0, 0x7f0903e9

    invoke-virtual {p0, v0}, Lchat/ola/vn/i/s;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ProgressBar;

    iput-object v0, p0, Lchat/ola/vn/i/s;->b:Landroid/widget/ProgressBar;

    const v0, 0x7f09058f

    invoke-virtual {p0, v0}, Lchat/ola/vn/i/s;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/i/s;->e:Landroid/widget/TextView;

    const v0, 0x7f090577

    invoke-virtual {p0, v0}, Lchat/ola/vn/i/s;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/i/s;->c:Landroid/widget/TextView;

    const v0, 0x7f090581

    invoke-virtual {p0, v0}, Lchat/ola/vn/i/s;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/i/s;->d:Landroid/widget/TextView;

    const v0, 0x7f0900ad

    invoke-virtual {p0, v0}, Lchat/ola/vn/i/s;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lchat/ola/vn/i/s;->f:Landroid/widget/Button;

    iget-object v0, p0, Lchat/ola/vn/i/s;->f:Landroid/widget/Button;

    invoke-virtual {v0, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const v0, 0x7f070143

    invoke-virtual {p1, v0}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p1

    iput p1, p0, Lchat/ola/vn/i/s;->h:I

    return-void
.end method

.method public static a(Landroid/content/Context;Lchat/ola/vn/i/s$a;Ljava/util/List;S)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Lchat/ola/vn/i/s$a;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;S)V"
        }
    .end annotation

    :try_start_0
    new-instance v0, Lchat/ola/vn/i/s;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/i/s;-><init>(Landroid/content/Context;Lchat/ola/vn/i/s$a;)V

    const/4 p0, 0x0

    invoke-virtual {v0, p0}, Lchat/ola/vn/i/s;->setCancelable(Z)V

    invoke-virtual {v0, p2, p3}, Lchat/ola/vn/i/s;->a(Ljava/util/List;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/i/s;JJ)V
    .locals 0

    invoke-direct {p0, p1, p2, p3, p4}, Lchat/ola/vn/i/s;->a(JJ)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/i/s;)Lchat/ola/vn/i/s$a;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/i/s;->g:Lchat/ola/vn/i/s$a;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/i/s;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/i/s;->k:Ljava/util/List;

    return-object p0
.end method


# virtual methods
.method public a(Ljava/util/List;S)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;S)V"
        }
    .end annotation

    if-eqz p1, :cond_1

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_1

    iput-object p1, p0, Lchat/ola/vn/i/s;->k:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/i/s;->l:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    if-nez p2, :cond_0

    invoke-static {v0}, Lchat/ola/vn/util/o;->d(Ljava/lang/String;)S

    move-result p2

    :cond_0
    invoke-static {}, Lchat/ola/vn/u/b;->a()Lchat/ola/vn/u/b;

    move-result-object v1

    const/4 v2, 0x0

    new-instance v3, Lchat/ola/vn/i/s$1;

    invoke-direct {v3, p0, v0}, Lchat/ola/vn/i/s$1;-><init>(Lchat/ola/vn/i/s;Ljava/lang/String;)V

    invoke-virtual {v1, v0, v2, v3}, Lchat/ola/vn/u/b;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/u/o;)Lchat/ola/vn/u/p;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/i/s;->l:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/i/s;->show()V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f0900ad

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/i/s;->l:Ljava/util/List;

    if-eqz p1, :cond_1

    invoke-static {}, Lchat/ola/vn/u/b;->a()Lchat/ola/vn/u/b;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/i/s;->l:Ljava/util/List;

    invoke-virtual {p1, v0}, Lchat/ola/vn/u/b;->a(Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/i/s;->l:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->clear()V

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/i/s;->dismiss()V

    return-void
.end method

.method public onDismiss(Landroid/content/DialogInterface;)V
    .locals 1

    iget-object p1, p0, Lchat/ola/vn/i/s;->l:Ljava/util/List;

    if-eqz p1, :cond_0

    invoke-static {}, Lchat/ola/vn/u/b;->a()Lchat/ola/vn/u/b;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/i/s;->l:Ljava/util/List;

    invoke-virtual {p1, v0}, Lchat/ola/vn/u/b;->a(Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/i/s;->l:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->clear()V

    :cond_0
    return-void
.end method

.method public setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)V
    .locals 0

    return-void
.end method
