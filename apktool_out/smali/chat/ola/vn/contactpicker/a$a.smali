.class Lchat/ola/vn/contactpicker/a$a;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/contactpicker/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field protected a:Lchat/ola/vn/view/OlaCachedImageView;

.field protected b:Landroid/widget/ImageView;

.field protected c:Landroid/widget/TextView;

.field protected d:Landroid/widget/TextView;

.field protected e:Landroid/view/View;

.field protected f:Landroid/view/View;

.field protected g:Landroid/view/View;

.field final synthetic h:Lchat/ola/vn/contactpicker/a;

.field private i:Lchat/ola/vn/contactpicker/a$b;


# direct methods
.method protected constructor <init>(Lchat/ola/vn/contactpicker/a;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/contactpicker/a$a;->h:Lchat/ola/vn/contactpicker/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const p1, 0x7f0902ca

    :try_start_0
    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/contactpicker/a$a;->d:Landroid/widget/TextView;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const p1, 0x7f0901be

    :try_start_1
    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/contactpicker/a$a;->g:Landroid/view/View;

    const p1, 0x7f0901ba

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/contactpicker/a$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const p1, 0x7f090460

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageView;

    iput-object p1, p0, Lchat/ola/vn/contactpicker/a$a;->b:Landroid/widget/ImageView;

    const p1, 0x7f0901b9

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/contactpicker/a$a;->c:Landroid/widget/TextView;

    const p1, 0x7f09030a

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/contactpicker/a$a;->f:Landroid/view/View;

    const p1, 0x7f0901c0

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/contactpicker/a$a;->e:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/contactpicker/a$a;->e:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method


# virtual methods
.method protected a(Lchat/ola/vn/contactpicker/a$b;Lchat/ola/vn/contactpicker/a$b;Lchat/ola/vn/contactpicker/a$b;)V
    .locals 0

    :try_start_0
    iput-object p1, p0, Lchat/ola/vn/contactpicker/a$a;->i:Lchat/ola/vn/contactpicker/a$b;

    iget-object p2, p0, Lchat/ola/vn/contactpicker/a$a;->i:Lchat/ola/vn/contactpicker/a$b;

    iget-byte p2, p2, Lchat/ola/vn/contactpicker/a$b;->a:B

    const/4 p3, 0x1

    if-ne p2, p3, :cond_0

    iget-object p2, p0, Lchat/ola/vn/contactpicker/a$a;->d:Landroid/widget/TextView;

    iget-object p1, p1, Lchat/ola/vn/contactpicker/a$b;->b:Ljava/lang/String;

    invoke-virtual {p2, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/contactpicker/a$a;->i:Lchat/ola/vn/contactpicker/a$b;

    if-nez p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/contactpicker/a$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const p2, 0x7f0806a5

    invoke-virtual {p1, p2}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/contactpicker/a$a;->i:Lchat/ola/vn/contactpicker/a$b;

    iget-boolean p1, p1, Lchat/ola/vn/contactpicker/a$b;->f:Z

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/contactpicker/a$a;->f:Landroid/view/View;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/contactpicker/a$a;->f:Landroid/view/View;

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/contactpicker/a$a;->e:Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/contactpicker/a$a;->i:Lchat/ola/vn/contactpicker/a$b;

    invoke-virtual {p1, p2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/contactpicker/a$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    if-eqz p1, :cond_3

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/contactpicker/a$a;->i:Lchat/ola/vn/contactpicker/a$b;

    iget-object p2, p2, Lchat/ola/vn/contactpicker/a$b;->c:Lchat/ola/vn/message/f;

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p2

    iget-object p3, p0, Lchat/ola/vn/contactpicker/a$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, p2, p3}, Lchat/ola/vn/c/t;->g(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :cond_3
    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/contactpicker/a$a;->c:Landroid/widget/TextView;

    iget-object p2, p0, Lchat/ola/vn/contactpicker/a$a;->i:Lchat/ola/vn/contactpicker/a$b;

    iget-object p2, p2, Lchat/ola/vn/contactpicker/a$b;->c:Lchat/ola/vn/message/f;

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    iget-object p1, p0, Lchat/ola/vn/contactpicker/a$a;->i:Lchat/ola/vn/contactpicker/a$b;

    iget-boolean p1, p1, Lchat/ola/vn/contactpicker/a$b;->d:Z

    if-eqz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/contactpicker/a$a;->b:Landroid/widget/ImageView;

    const p2, 0x7f08069a

    invoke-virtual {p1, p2}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/contactpicker/a$a;->g:Landroid/view/View;

    sget p2, Lchat/ola/vn/f;->I:I

    :goto_1
    invoke-virtual {p1, p2}, Landroid/view/View;->setBackgroundColor(I)V

    return-void

    :cond_4
    iget-object p1, p0, Lchat/ola/vn/contactpicker/a$a;->b:Landroid/widget/ImageView;

    const p2, 0x7f080728

    invoke-virtual {p1, p2}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/contactpicker/a$a;->g:Landroid/view/View;

    sget p2, Lchat/ola/vn/f;->d:I
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_1

    :catch_1
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 2

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const v1, 0x7f0901c0

    if-eq v0, v1, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/contactpicker/a$b;

    iget-boolean v0, p1, Lchat/ola/vn/contactpicker/a$b;->d:Z

    xor-int/lit8 v0, v0, 0x1

    iput-boolean v0, p1, Lchat/ola/vn/contactpicker/a$b;->d:Z

    iget-boolean v0, p1, Lchat/ola/vn/contactpicker/a$b;->d:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/contactpicker/a$a;->b:Landroid/widget/ImageView;

    const v1, 0x7f08069a

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v0, p0, Lchat/ola/vn/contactpicker/a$a;->g:Landroid/view/View;

    sget v1, Lchat/ola/vn/f;->I:I

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundColor(I)V

    iget-object v0, p0, Lchat/ola/vn/contactpicker/a$a;->h:Lchat/ola/vn/contactpicker/a;

    iget-object v0, v0, Lchat/ola/vn/contactpicker/a;->b:Lchat/ola/vn/contactpicker/OlaContactPickerActivity$c;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/contactpicker/a$a;->h:Lchat/ola/vn/contactpicker/a;

    iget-object v0, v0, Lchat/ola/vn/contactpicker/a;->b:Lchat/ola/vn/contactpicker/OlaContactPickerActivity$c;

    iget-object p1, p1, Lchat/ola/vn/contactpicker/a$b;->c:Lchat/ola/vn/message/f;

    invoke-interface {v0, p1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$c;->a(Lchat/ola/vn/message/f;)V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/contactpicker/a$a;->b:Landroid/widget/ImageView;

    const v1, 0x7f080728

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v0, p0, Lchat/ola/vn/contactpicker/a$a;->g:Landroid/view/View;

    sget v1, Lchat/ola/vn/f;->d:I

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundColor(I)V

    iget-object v0, p0, Lchat/ola/vn/contactpicker/a$a;->h:Lchat/ola/vn/contactpicker/a;

    iget-object v0, v0, Lchat/ola/vn/contactpicker/a;->b:Lchat/ola/vn/contactpicker/OlaContactPickerActivity$c;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/contactpicker/a$a;->h:Lchat/ola/vn/contactpicker/a;

    iget-object v0, v0, Lchat/ola/vn/contactpicker/a;->b:Lchat/ola/vn/contactpicker/OlaContactPickerActivity$c;

    iget-object p1, p1, Lchat/ola/vn/contactpicker/a$b;->c:Lchat/ola/vn/message/f;

    invoke-interface {v0, p1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$c;->b(Lchat/ola/vn/message/f;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method
