.class public Lchat/ola/vn/i/b;
.super Lchat/ola/vn/i/n;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private a:Landroid/widget/TextView;

.field private b:Landroid/widget/TextView;

.field private c:Landroid/widget/ImageView;

.field private d:Landroid/widget/EditText;

.field private e:Landroid/widget/Button;


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Landroid/graphics/Bitmap;)V
    .locals 2

    invoke-direct {p0, p1}, Lchat/ola/vn/i/n;-><init>(Landroid/content/Context;)V

    const v0, 0x7f0b0030

    invoke-virtual {p0, v0}, Lchat/ola/vn/i/b;->setContentView(I)V

    invoke-virtual {p0}, Lchat/ola/vn/i/b;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/view/Window;->setSoftInputMode(I)V

    invoke-virtual {p0}, Lchat/ola/vn/i/b;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const v1, 0x7f0700db

    invoke-virtual {p1, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p1

    iput p1, v0, Landroid/view/WindowManager$LayoutParams;->width:I

    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/b;->setCancelable(Z)V

    const p1, 0x7f09052a

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/b;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/i/b;->a:Landroid/widget/TextView;

    const p1, 0x7f090513

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/b;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/i/b;->b:Landroid/widget/TextView;

    const p1, 0x7f090266

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/b;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageView;

    iput-object p1, p0, Lchat/ola/vn/i/b;->c:Landroid/widget/ImageView;

    iget-object p1, p0, Lchat/ola/vn/i/b;->c:Landroid/widget/ImageView;

    invoke-virtual {p1, p4}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    const p1, 0x7f0904fb

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/b;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lchat/ola/vn/i/b;->d:Landroid/widget/EditText;

    const p1, 0x7f0900ad

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/b;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/i/b;->e:Landroid/widget/Button;

    iget-object p1, p0, Lchat/ola/vn/i/b;->a:Landroid/widget/TextView;

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/i/b;->b:Landroid/widget/TextView;

    invoke-virtual {p1, p3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/i/b;->e:Landroid/widget/Button;

    invoke-virtual {p1, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f0900ad

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/i/b;->d:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-nez v0, :cond_1

    :try_start_1
    invoke-virtual {p0}, Lchat/ola/vn/i/b;->getContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/i/b;->d:Landroid/widget/EditText;

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, p1}, Lchat/ola/vn/network/OlaNetworkService;->y(Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/i/b;->dismiss()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_1
    return-void
.end method
