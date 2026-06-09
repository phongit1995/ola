.class Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a;
.super Lchat/ola/vn/b/j;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/contactpicker/OlaContactPickerActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/b/j<",
        "Lchat/ola/vn/message/f;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

.field private b:Landroid/view/LayoutInflater;


# direct methods
.method public constructor <init>(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;Landroid/content/Context;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-direct {p0, p2}, Lchat/ola/vn/b/j;-><init>(Landroid/content/Context;)V

    invoke-static {p2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a;->b:Landroid/view/LayoutInflater;

    return-void
.end method


# virtual methods
.method public a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 2

    invoke-virtual {p0, p1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a;->a(I)Lchat/ola/vn/message/f;

    move-result-object p1

    if-nez p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a;->b:Landroid/view/LayoutInflater;

    const p3, 0x7f0b0026

    const/4 v0, 0x0

    invoke-virtual {p2, p3, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p2

    new-instance p3, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a$1;

    invoke-direct {p3, p0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a$1;-><init>(Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a;)V

    invoke-virtual {p2, p3}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_0
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object p3

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    const v1, 0x7f090085

    invoke-virtual {p2, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p3, v0, v1}, Lchat/ola/vn/c/t;->g(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    invoke-virtual {p2, p1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    return-object p2
.end method

.method public a(I)Lchat/ola/vn/message/f;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {v0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->d(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/f;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public getCount()I
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {v0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->d(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public synthetic getItem(I)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a;->a(I)Lchat/ola/vn/message/f;

    move-result-object p1

    return-object p1
.end method

.method public getItemViewType(I)I
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public getViewTypeCount()I
    .locals 1

    const/4 v0, 0x1

    return v0
.end method
