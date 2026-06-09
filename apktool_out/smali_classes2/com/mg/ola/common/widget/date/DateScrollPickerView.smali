.class public Lcom/mg/ola/common/widget/date/DateScrollPickerView;
.super Lcom/mg/ola/common/widget/date/ScrollPickerView;


# instance fields
.field protected a:I

.field protected b:I

.field protected c:I

.field private d:Ljava/text/SimpleDateFormat;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/mg/ola/common/widget/date/ScrollPickerView;-><init>(Landroid/content/Context;)V

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->a()V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/mg/ola/common/widget/date/ScrollPickerView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->a()V

    return-void
.end method


# virtual methods
.method protected a()V
    .locals 6

    new-instance v0, Ljava/text/SimpleDateFormat;

    const-string v1, "dd/MM/yyyy"

    invoke-direct {v0, v1}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->d:Ljava/text/SimpleDateFormat;

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f030017

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/mg/ola/common/widget/date/ScrollPickerView$ScrollType;->b:Lcom/mg/ola/common/widget/date/ScrollPickerView$ScrollType;

    const/high16 v2, 0x40a00000    # 5.0f

    invoke-virtual {p0, v0, v2, v1}, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->a([Ljava/lang/String;FLcom/mg/ola/common/widget/date/ScrollPickerView$ScrollType;)V

    const/4 v0, 0x1

    new-array v1, v0, [Ljava/lang/String;

    const-string v3, "/"

    const/4 v4, 0x0

    aput-object v3, v1, v4

    sget-object v3, Lcom/mg/ola/common/widget/date/ScrollPickerView$ScrollType;->c:Lcom/mg/ola/common/widget/date/ScrollPickerView$ScrollType;

    const/high16 v5, 0x40000000    # 2.0f

    invoke-virtual {p0, v1, v5, v3}, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->a([Ljava/lang/String;FLcom/mg/ola/common/widget/date/ScrollPickerView$ScrollType;)V

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v3, 0x7f030003

    invoke-virtual {v1, v3}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object v1

    sget-object v3, Lcom/mg/ola/common/widget/date/ScrollPickerView$ScrollType;->b:Lcom/mg/ola/common/widget/date/ScrollPickerView$ScrollType;

    invoke-virtual {p0, v1, v2, v3}, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->a([Ljava/lang/String;FLcom/mg/ola/common/widget/date/ScrollPickerView$ScrollType;)V

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "/"

    aput-object v1, v0, v4

    sget-object v1, Lcom/mg/ola/common/widget/date/ScrollPickerView$ScrollType;->c:Lcom/mg/ola/common/widget/date/ScrollPickerView$ScrollType;

    invoke-virtual {p0, v0, v5, v1}, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->a([Ljava/lang/String;FLcom/mg/ola/common/widget/date/ScrollPickerView$ScrollType;)V

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f030005

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/mg/ola/common/widget/date/ScrollPickerView$ScrollType;->a:Lcom/mg/ola/common/widget/date/ScrollPickerView$ScrollType;

    const/high16 v2, 0x41200000    # 10.0f

    invoke-virtual {p0, v0, v2, v1}, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->a([Ljava/lang/String;FLcom/mg/ola/common/widget/date/ScrollPickerView$ScrollType;)V

    iput v4, p0, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->c:I

    const/4 v0, 0x2

    iput v0, p0, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->b:I

    const/4 v0, 0x4

    iput v0, p0, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->a:I

    return-void
.end method

.method public a(IZ)V
    .locals 0

    if-eqz p2, :cond_0

    iget p2, p0, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->a:I

    add-int/lit16 p1, p1, -0x7b2

    invoke-virtual {p0, p2, p1}, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->b(II)V

    return-void

    :cond_0
    iget p2, p0, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->a:I

    add-int/lit16 p1, p1, -0x7b2

    invoke-virtual {p0, p2, p1}, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->a(II)V

    return-void
.end method

.method public b(IZ)V
    .locals 0

    if-eqz p2, :cond_0

    iget p2, p0, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->b:I

    add-int/lit8 p1, p1, -0x1

    invoke-virtual {p0, p2, p1}, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->b(II)V

    return-void

    :cond_0
    iget p2, p0, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->b:I

    add-int/lit8 p1, p1, -0x1

    invoke-virtual {p0, p2, p1}, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->a(II)V

    return-void
.end method

.method public c(IZ)V
    .locals 0

    if-eqz p2, :cond_0

    iget p2, p0, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->c:I

    add-int/lit8 p1, p1, -0x1

    invoke-virtual {p0, p2, p1}, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->b(II)V

    return-void

    :cond_0
    iget p2, p0, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->c:I

    add-int/lit8 p1, p1, -0x1

    invoke-virtual {p0, p2, p1}, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->a(II)V

    return-void
.end method

.method public getDay()I
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->c:I

    invoke-virtual {p0, v0}, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->a(I)I

    move-result v0

    add-int/lit8 v0, v0, 0x1

    return v0
.end method

.method public getMonth()I
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->b:I

    invoke-virtual {p0, v0}, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->a(I)I

    move-result v0

    add-int/lit8 v0, v0, 0x1

    return v0
.end method

.method public getYear()I
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->a:I

    invoke-virtual {p0, v0}, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->a(I)I

    move-result v0

    add-int/lit16 v0, v0, 0x7b2

    return v0
.end method

.method public setCurrentDate(Z)V
    .locals 2

    iget-object v0, p0, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->d:Ljava/text/SimpleDateFormat;

    new-instance v1, Ljava/util/Date;

    invoke-direct {v1}, Ljava/util/Date;-><init>()V

    invoke-virtual {v0, v1}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    aget-object v1, v0, v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {p0, v1, p1}, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->a(IZ)V

    const/4 v1, 0x1

    aget-object v1, v0, v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {p0, v1, p1}, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->b(IZ)V

    const/4 v1, 0x2

    aget-object v0, v0, v1

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p0, v0, p1}, Lcom/mg/ola/common/widget/date/DateScrollPickerView;->c(IZ)V

    return-void
.end method
