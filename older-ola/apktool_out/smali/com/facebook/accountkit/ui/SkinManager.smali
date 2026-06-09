.class public final Lcom/facebook/accountkit/ui/SkinManager;
.super Lcom/facebook/accountkit/ui/BaseUIManager;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/ui/SkinManager$Tint;,
        Lcom/facebook/accountkit/ui/SkinManager$Skin;
    }
.end annotation


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lcom/facebook/accountkit/ui/SkinManager;",
            ">;"
        }
    .end annotation
.end field

.field private static final DISABLED_COLOR_ALPHA:D = 0.25

.field private static final MAXIMUM_TINT_INTENSITY:D = 0.85

.field private static final MINIMUM_TINT_INTENSITY:D = 0.55


# instance fields
.field private final backgroundImage:I
    .annotation build Landroid/support/annotation/DrawableRes;
    .end annotation
.end field

.field private final primaryColor:I
    .annotation build Landroid/support/annotation/ColorInt;
    .end annotation
.end field

.field private final skin:Lcom/facebook/accountkit/ui/SkinManager$Skin;

.field private final tint:Lcom/facebook/accountkit/ui/SkinManager$Tint;

.field private final tintIntensity:D


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/facebook/accountkit/ui/SkinManager$1;

    invoke-direct {v0}, Lcom/facebook/accountkit/ui/SkinManager$1;-><init>()V

    sput-object v0, Lcom/facebook/accountkit/ui/SkinManager;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method private constructor <init>(Landroid/os/Parcel;)V
    .locals 2

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/BaseUIManager;-><init>(Landroid/os/Parcel;)V

    invoke-static {}, Lcom/facebook/accountkit/ui/SkinManager$Skin;->values()[Lcom/facebook/accountkit/ui/SkinManager$Skin;

    move-result-object v0

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    aget-object v0, v0, v1

    iput-object v0, p0, Lcom/facebook/accountkit/ui/SkinManager;->skin:Lcom/facebook/accountkit/ui/SkinManager$Skin;

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    iput v0, p0, Lcom/facebook/accountkit/ui/SkinManager;->primaryColor:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    iput v0, p0, Lcom/facebook/accountkit/ui/SkinManager;->backgroundImage:I

    invoke-static {}, Lcom/facebook/accountkit/ui/SkinManager$Tint;->values()[Lcom/facebook/accountkit/ui/SkinManager$Tint;

    move-result-object v0

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    aget-object v0, v0, v1

    iput-object v0, p0, Lcom/facebook/accountkit/ui/SkinManager;->tint:Lcom/facebook/accountkit/ui/SkinManager$Tint;

    invoke-virtual {p1}, Landroid/os/Parcel;->readDouble()D

    move-result-wide v0

    iput-wide v0, p0, Lcom/facebook/accountkit/ui/SkinManager;->tintIntensity:D

    return-void
.end method

.method synthetic constructor <init>(Landroid/os/Parcel;Lcom/facebook/accountkit/ui/SkinManager$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/SkinManager;-><init>(Landroid/os/Parcel;)V

    return-void
.end method

.method public constructor <init>(Lcom/facebook/accountkit/ui/SkinManager$Skin;I)V
    .locals 7
    .param p2    # I
        .annotation build Landroid/support/annotation/ColorInt;
        .end annotation
    .end param

    sget-object v4, Lcom/facebook/accountkit/ui/SkinManager$Tint;->WHITE:Lcom/facebook/accountkit/ui/SkinManager$Tint;

    const/4 v3, -0x1

    const-wide v5, 0x3fe199999999999aL    # 0.55

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    invoke-direct/range {v0 .. v6}, Lcom/facebook/accountkit/ui/SkinManager;-><init>(Lcom/facebook/accountkit/ui/SkinManager$Skin;IILcom/facebook/accountkit/ui/SkinManager$Tint;D)V

    return-void
.end method

.method public constructor <init>(Lcom/facebook/accountkit/ui/SkinManager$Skin;IILcom/facebook/accountkit/ui/SkinManager$Tint;D)V
    .locals 2
    .param p2    # I
        .annotation build Landroid/support/annotation/ColorInt;
        .end annotation
    .end param
    .param p3    # I
        .annotation build Landroid/support/annotation/DrawableRes;
        .end annotation
    .end param

    const/4 v0, -0x1

    invoke-direct {p0, v0}, Lcom/facebook/accountkit/ui/BaseUIManager;-><init>(I)V

    iput-object p1, p0, Lcom/facebook/accountkit/ui/SkinManager;->skin:Lcom/facebook/accountkit/ui/SkinManager$Skin;

    iput p2, p0, Lcom/facebook/accountkit/ui/SkinManager;->primaryColor:I

    iput p3, p0, Lcom/facebook/accountkit/ui/SkinManager;->backgroundImage:I

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/SkinManager;->hasBackgroundImage()Z

    move-result p1

    const-wide p2, 0x3fe199999999999aL    # 0.55

    if-eqz p1, :cond_0

    iput-object p4, p0, Lcom/facebook/accountkit/ui/SkinManager;->tint:Lcom/facebook/accountkit/ui/SkinManager$Tint;

    const-wide v0, 0x3feb333333333333L    # 0.85

    invoke-static {p2, p3, p5, p6}, Ljava/lang/Math;->max(DD)D

    move-result-wide p1

    invoke-static {v0, v1, p1, p2}, Ljava/lang/Math;->min(DD)D

    move-result-wide p1

    iput-wide p1, p0, Lcom/facebook/accountkit/ui/SkinManager;->tintIntensity:D

    return-void

    :cond_0
    sget-object p1, Lcom/facebook/accountkit/ui/SkinManager$Tint;->WHITE:Lcom/facebook/accountkit/ui/SkinManager$Tint;

    iput-object p1, p0, Lcom/facebook/accountkit/ui/SkinManager;->tint:Lcom/facebook/accountkit/ui/SkinManager$Tint;

    iput-wide p2, p0, Lcom/facebook/accountkit/ui/SkinManager;->tintIntensity:D

    return-void
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method getBackgroundImageResId()I
    .locals 1
    .annotation build Landroid/support/annotation/DrawableRes;
    .end annotation

    iget v0, p0, Lcom/facebook/accountkit/ui/SkinManager;->backgroundImage:I

    return v0
.end method

.method public getBodyFragment(Lcom/facebook/accountkit/ui/LoginFlowState;)Landroid/app/Fragment;
    .locals 0
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/BaseUIManager;->getBodyFragment(Lcom/facebook/accountkit/ui/LoginFlowState;)Landroid/app/Fragment;

    move-result-object p1

    return-object p1
.end method

.method public getButtonType(Lcom/facebook/accountkit/ui/LoginFlowState;)Lcom/facebook/accountkit/ui/ButtonType;
    .locals 0
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/BaseUIManager;->getButtonType(Lcom/facebook/accountkit/ui/LoginFlowState;)Lcom/facebook/accountkit/ui/ButtonType;

    move-result-object p1

    return-object p1
.end method

.method getDisabledColor(I)I
    .locals 11
    .param p1    # I
        .annotation build Landroid/support/annotation/ColorInt;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/ColorInt;
    .end annotation

    sget-object v0, Lcom/facebook/accountkit/ui/SkinManager$2;->$SwitchMap$com$facebook$accountkit$ui$SkinManager$Tint:[I

    iget-object v1, p0, Lcom/facebook/accountkit/ui/SkinManager;->tint:Lcom/facebook/accountkit/ui/SkinManager$Tint;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/SkinManager$Tint;->ordinal()I

    move-result v1

    aget v0, v0, v1

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    const/high16 v0, -0x1000000

    goto :goto_0

    :cond_0
    const/4 v0, -0x1

    :goto_0
    invoke-static {p1}, Landroid/graphics/Color;->red(I)I

    move-result v1

    int-to-double v1, v1

    const-wide/high16 v3, 0x3fd0000000000000L    # 0.25

    mul-double v1, v1, v3

    invoke-static {v0}, Landroid/graphics/Color;->red(I)I

    move-result v5

    int-to-double v5, v5

    const-wide/high16 v7, 0x3fe8000000000000L    # 0.75

    mul-double v5, v5, v7

    add-double/2addr v1, v5

    invoke-static {p1}, Landroid/graphics/Color;->green(I)I

    move-result v5

    int-to-double v5, v5

    mul-double v5, v5, v3

    invoke-static {v0}, Landroid/graphics/Color;->green(I)I

    move-result v9

    int-to-double v9, v9

    mul-double v9, v9, v7

    add-double/2addr v5, v9

    invoke-static {p1}, Landroid/graphics/Color;->blue(I)I

    move-result p1

    int-to-double v9, p1

    mul-double v9, v9, v3

    invoke-static {v0}, Landroid/graphics/Color;->blue(I)I

    move-result p1

    int-to-double v3, p1

    mul-double v3, v3, v7

    add-double/2addr v9, v3

    double-to-int p1, v1

    double-to-int v0, v5

    double-to-int v1, v9

    invoke-static {p1, v0, v1}, Landroid/graphics/Color;->rgb(III)I

    move-result p1

    return p1
.end method

.method public getFooterFragment(Lcom/facebook/accountkit/ui/LoginFlowState;)Landroid/app/Fragment;
    .locals 0
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/BaseUIManager;->getFooterFragment(Lcom/facebook/accountkit/ui/LoginFlowState;)Landroid/app/Fragment;

    move-result-object p1

    return-object p1
.end method

.method public getHeaderFragment(Lcom/facebook/accountkit/ui/LoginFlowState;)Landroid/app/Fragment;
    .locals 0
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/BaseUIManager;->getHeaderFragment(Lcom/facebook/accountkit/ui/LoginFlowState;)Landroid/app/Fragment;

    move-result-object p1

    return-object p1
.end method

.method public getPrimaryColor()I
    .locals 1
    .annotation build Landroid/support/annotation/ColorInt;
    .end annotation

    iget v0, p0, Lcom/facebook/accountkit/ui/SkinManager;->primaryColor:I

    return v0
.end method

.method public getSkin()Lcom/facebook/accountkit/ui/SkinManager$Skin;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/SkinManager;->skin:Lcom/facebook/accountkit/ui/SkinManager$Skin;

    return-object v0
.end method

.method getTextColor()I
    .locals 2
    .annotation build Landroid/support/annotation/ColorInt;
    .end annotation

    sget-object v0, Lcom/facebook/accountkit/ui/SkinManager$2;->$SwitchMap$com$facebook$accountkit$ui$SkinManager$Tint:[I

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/SkinManager;->getTint()Lcom/facebook/accountkit/ui/SkinManager$Tint;

    move-result-object v1

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/SkinManager$Tint;->ordinal()I

    move-result v1

    aget v0, v0, v1

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    const/high16 v0, -0x1000000

    return v0

    :cond_0
    const/4 v0, -0x1

    return v0
.end method

.method public getTextPosition(Lcom/facebook/accountkit/ui/LoginFlowState;)Lcom/facebook/accountkit/ui/TextPosition;
    .locals 0
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/BaseUIManager;->getTextPosition(Lcom/facebook/accountkit/ui/LoginFlowState;)Lcom/facebook/accountkit/ui/TextPosition;

    move-result-object p1

    return-object p1
.end method

.method public getTint()Lcom/facebook/accountkit/ui/SkinManager$Tint;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/SkinManager;->tint:Lcom/facebook/accountkit/ui/SkinManager$Tint;

    return-object v0
.end method

.method getTintColor()I
    .locals 5
    .annotation build Landroid/support/annotation/ColorInt;
    .end annotation

    sget-object v0, Lcom/facebook/accountkit/ui/SkinManager$2;->$SwitchMap$com$facebook$accountkit$ui$SkinManager$Tint:[I

    iget-object v1, p0, Lcom/facebook/accountkit/ui/SkinManager;->tint:Lcom/facebook/accountkit/ui/SkinManager$Tint;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/SkinManager$Tint;->ordinal()I

    move-result v1

    aget v0, v0, v1

    const-wide v1, 0x406fe00000000000L    # 255.0

    const/4 v3, 0x1

    if-eq v0, v3, :cond_0

    iget-wide v3, p0, Lcom/facebook/accountkit/ui/SkinManager;->tintIntensity:D

    mul-double v3, v3, v1

    double-to-int v0, v3

    const/4 v1, 0x0

    :goto_0
    invoke-static {v0, v1, v1, v1}, Landroid/graphics/Color;->argb(IIII)I

    move-result v0

    return v0

    :cond_0
    iget-wide v3, p0, Lcom/facebook/accountkit/ui/SkinManager;->tintIntensity:D

    mul-double v3, v3, v1

    double-to-int v0, v3

    const/16 v1, 0xff

    goto :goto_0

    return v0
.end method

.method public getTintIntensity()D
    .locals 2

    iget-wide v0, p0, Lcom/facebook/accountkit/ui/SkinManager;->tintIntensity:D

    return-wide v0
.end method

.method public hasBackgroundImage()Z
    .locals 1

    iget v0, p0, Lcom/facebook/accountkit/ui/SkinManager;->backgroundImage:I

    if-ltz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 2

    invoke-super {p0, p1, p2}, Lcom/facebook/accountkit/ui/BaseUIManager;->writeToParcel(Landroid/os/Parcel;I)V

    iget-object p2, p0, Lcom/facebook/accountkit/ui/SkinManager;->skin:Lcom/facebook/accountkit/ui/SkinManager$Skin;

    invoke-virtual {p2}, Lcom/facebook/accountkit/ui/SkinManager$Skin;->ordinal()I

    move-result p2

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeInt(I)V

    iget p2, p0, Lcom/facebook/accountkit/ui/SkinManager;->primaryColor:I

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeInt(I)V

    iget p2, p0, Lcom/facebook/accountkit/ui/SkinManager;->backgroundImage:I

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeInt(I)V

    iget-object p2, p0, Lcom/facebook/accountkit/ui/SkinManager;->tint:Lcom/facebook/accountkit/ui/SkinManager$Tint;

    invoke-virtual {p2}, Lcom/facebook/accountkit/ui/SkinManager$Tint;->ordinal()I

    move-result p2

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeInt(I)V

    iget-wide v0, p0, Lcom/facebook/accountkit/ui/SkinManager;->tintIntensity:D

    invoke-virtual {p1, v0, v1}, Landroid/os/Parcel;->writeDouble(D)V

    return-void
.end method
